From: Vadim Zeitlin <vz-git@zeitlins.org>
Subject: Re[2]: Possible bug: --ext-diff ignored with --cc in git log
Date: Sat, 12 Mar 2016 02:08:12 +0100
Message-ID: <E1aeY2d-0006K7-6e@smtp.tt-solutions.com>
References: <E1adi8q-0005NJ-4G@smtp.tt-solutions.com><xmqqlh5qc698.fsf@gitster.mtv.corp.google.com><E1aeCRp-0005Jn-C1@smtp.tt-solutions.com> <xmqqziu4anb9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: MULTIPART/SIGNED; protocol="application/pgp-signature"; micalg=pgp-sha1; BOUNDARY="1124392672-41-1457744892=:12660"
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 12 02:08:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeY2p-0006ZM-Bj
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 02:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbcCLBIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 20:08:34 -0500
Received: from sunset.tt-solutions.com ([82.240.17.225]:49577 "EHLO
	smtp.tt-solutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbcCLBIe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 20:08:34 -0500
Received: from [192.168.17.86] (helo=Twilight)
	by smtp.tt-solutions.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <vz-git@zeitlins.org>)
	id 1aeY2d-0006K7-6e; Sat, 12 Mar 2016 02:08:27 +0100
In-Reply-To: <xmqqziu4anb9.fsf@gitster.mtv.corp.google.com>
X-Mailer: Mahogany 0.68.0 'Cynthia', running under Windows 7 (build 7601, Service Pack 1), 64-bit edition
X-VZ-SMTP-Helo: Twilight
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288723>

--1124392672-41-1457744892=:12660
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE

On Fri, 11 Mar 2016 10:20:42 -0800 Junio C Hamano <gitster@pobox.com> wrote:

JCH> Vadim Zeitlin <vz-git@zeitlins.org> writes:
JCH> 
JCH> >  Thank you for your reply, Junio, I hadn't realized that --cc was dependent
JCH> > on textual diff output format before, but now I understand why it can't
JCH> > respect --ext-diff.
JCH> 
JCH> Having established that, I should also add that "--cc fundamentally
JCH> is incompatible with --ext-diff" does not justify that
JCH> "--cc when given with --ext-diff just ignores and uses the usual
JCH> diff".
JCH> 
JCH> An equally (or even more) valid consequence could have been to
JCH> disable "--cc" processing for paths that would trigger an external
JCH> diff driver.

 FWIW I agree that this would make more sense than the current behaviour.
But it still wouldn't be ideal if disabling "--cc" meant not showing any
output for these files at all, we still want to know that the file has been
modified as part of the commit, even if we don't care about its contents.

JCH> After all, the user told us that the contents would not compare well
JCH> with the usual "diff"; we know that "--cc" output that summarizes the
JCH> usual diff output is useless.

 This is so logical that it made me check how did "--cc" behave with the
binary files because this argument seems to apply perfectly well to them
too. And (unsurprisingly?) it already works just fine with them:

	# I have alias g=git and I also suppress all successful output
	$ g init
	$ echo 'Binary\0file' > binary
	$ g add binary
	$ g commit -m 'Added'
	$ echo '2nd line' >> binary
	$ g commit -a -m 'Added 2nd line'
	$ g checkout -b another HEAD~
	$ echo 'another line' >> binary
	$ g commit -a -m 'Added another line'
	$ g checkout master
	$ g merge
	warning: Cannot merge binary files: binary (HEAD vs. another)
	Auto-merging binary
	CONFLICT (content): Merge conflict in binary
	Automatic merge failed; fix conflicts and then commit the result.
	$ vi binary # combine both versions
	$ g commit
	$ g show # finally I can show what all this is about
	commit d30ae002cb52974228d50723fc8c9d7077e760da
	Merge: ae542d2 3204f35
	Author: Vadim Zeitlin <vz-xxx@zeitlins.org>
	Date:   Sat Mar 12 01:57:55 2016 +0100

	    Merge branch 'another'

	diff --cc binary
	index 31499e2,1730dfd..1eda50a
	Binary files differ

So it looks like it shouldn't be too difficult to make it also output
"Files using custom diff viewer differ", what do you think?

JCH> For example, we could also ignore what external diff driver
JCH> produces in this case (as we know it won't be producing an
JCH> appropriate input to the "--cc" post-processing), and pretend
JCH> as if comparing an old version of foo.sln with a new version of
JCH> foo.sln produced a diff like this:
JCH> 
JCH>     diff --git a/foo.sln b/foo.sln
JCH>     index d7ff46e,b829410
JCH>     --- a/foo.sln
JCH>     +++ b/foo.sln
JCH>     @@ 1,1 @@
JCH>     -d7ff46ec4a016c6ab7d233b9d4a196ecde623528  - generated file
JCH>     +b829410f6da0afc14353b4621d2fdf874181a9f7  - generated file
JCH> 
JCH> then you might see in a merge that merges two versions of foo.sln
JCH> and result in another version of foo.sln in your "--cc" output a
JCH> hunk that is like this:
JCH> 
JCH>     diff --cc foo.sln
JCH>     index d7ff46e,6c9aaa1..b829410
JCH>     --- a/foo.sln
JCH>     +++ b/foo.sln
JCH>     @@@ 1,1 @@@
JCH>     - d7ff46ec4a016c6ab7d233b9d4a196ecde623528  - generated file
JCH>      -6c9aaa1ae63a2255a215c1287e38e75fcc5fc5d3  - generated file
JCH>     ++b829410f6da0afc14353b4621d2fdf874181a9f7  - generated file
JCH> 
JCH> which would at least tell you that there was a merge, and if the
JCH> merge took the full contents of the file from one of the commits and
JCH> recorded as the result of the merge, then you wouldn't see them in
JCH> the "--cc" output.

 Interesting, but I admit I don't really see any advantage of showing the
SHA-1s here compared to what already happens with the binary files. Is
there anything I'm missing?

JCH> It happens that the above is fairly easily doable with today's Git
JCH> without any modification.  Here is how.
JCH> 
JCH> (1) Have this in your .git/config
JCH> 
JCH>     [diff "uninteresting"]
JCH>     	textconv = /path/to/uninteresting-textconv-script
JCH> 
JCH> (2) Mark your .sln paths as uninteresting in your .gitattributes
JCH> 
JCH>     *.sln	diff=uninteresting
JCH> 
JCH> (3) Have this textconv filter in /path/to/uninteresting-textconv-script
JCH> 
JCH>     #!/bin/sh
JCH>     printf "%s generated file\n" "$(sha1sum <"$1")"

 This is really ingenious, thanks! I'm probably indeed going to put this in
place at least for now for our mail notification script because it's just
too annoying to receive emails with thousands of lines of diffs to the
generated files.

 But I still think that it would make sense for "--cc" to behave as it does
for the binary files for the ext-diffable ones too. I've never touched git
code before but if you think it's a good idea and if you don't see any
insurmountable difficulties in implementing this, I could try to make a
patch doing it, please let me know if you think it could be useful.

 And thanks again for your textconv hint!
VZ

--1124392672-41-1457744892=:12660
Content-Type: APPLICATION/PGP-SIGNATURE

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)

iEYEABECAAYFAlbja/wACgkQBupB3k9sHoZxZACgkZry4lX6FeBB+awohb4W6BWA
9zEAn2Ryr8xRSDZ6f9KmJf3a/wqDFJ+e
=hwSK
-----END PGP SIGNATURE-----

--1124392672-41-1457744892=:12660--
