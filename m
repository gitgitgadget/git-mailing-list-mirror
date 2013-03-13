From: John Keeping <john@keeping.me.uk>
Subject: Re: difftool -d symlinks, under what conditions
Date: Wed, 13 Mar 2013 00:17:59 +0000
Message-ID: <20130313001758.GH2317@serenity.lan>
References: <CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
 <CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
 <20130312190956.GC2317@serenity.lan>
 <CAJDDKr7S0ex1RvZS0QeBXxAuqcKrQJzhZeJP0MoMGmpGXyMOrA@mail.gmail.com>
 <20130312194306.GE2317@serenity.lan>
 <7vfw0073pm.fsf@alter.siamese.dyndns.org>
 <20130312210630.GF2317@serenity.lan>
 <CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
 <7vehfk5kn2.fsf@alter.siamese.dyndns.org>
 <3222724986386016520@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 01:18:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFZOw-0003p9-1O
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 01:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636Ab3CMASL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 20:18:11 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:54755 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301Ab3CMASJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 20:18:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 44A1D161E52B;
	Wed, 13 Mar 2013 00:18:09 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gm2pKDE9Wcbz; Wed, 13 Mar 2013 00:18:08 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 41954161E11D;
	Wed, 13 Mar 2013 00:18:00 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <3222724986386016520@unknownmsgid>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218014>

On Tue, Mar 12, 2013 at 04:48:16PM -0600, Matt McClure wrote:
> On Mar 12, 2013, at 4:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> > Matt McClure <matthewlmcclure@gmail.com> writes:
> >
> > * If you are comparing two trees, and especially if your RHS is not
> >   HEAD, you will send everything to a temporary without
> >   symlinks. Any edit made by the user will be lost.
> 
> I think you're suggesting to use a symlink any time the content of any
> given RHS revision is the same as the working tree.
> 
> I imagine that might confuse me as a user. It would create
> circumstances where some files are symlinked and others aren't for
> reasons that won't be straightforward.
> 
> I imagine solving that case, I might instead implement a copy back to
> the working tree with conflict detection/resolution. Some earlier
> iterations of the directory diff feature used copy back without
> conflict detection and created situations where I clobbered my own
> changes by finishing a directory diff after making edits concurrently.

The code to copy back working tree files is already there, it just
triggers using the same logic as the creation of symlinks in the first
place and doesn't attempt any conflict detection.  I suspect that any
more comprehensive solution will need to restrict the use of "git
difftool -d" whenever the index contains unmerged entries or when there
are both staged and unstaged changes, since the merge resolution will
cause these states to be lost.

The implementation of Junio's suggestion is relatively straightforward
(this is untested, although t7800 passes, and can probably be improved
by someone better versed in Perl).  Does this work for your original
scenario?

-- >8 --
diff --git a/git-difftool.perl b/git-difftool.perl
index 0a90de4..5f093ae 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -83,6 +83,21 @@ sub exit_cleanup
 	exit($status | ($status >> 8));
 }
 
+sub use_wt_file
+{
+	my ($repo, $workdir, $file, $sha1, $symlinks) = @_;
+	my $null_sha1 = '0' x 40;
+
+	if ($sha1 eq $null_sha1) {
+		return 1;
+	} elsif (not $symlinks) {
+		return 0;
+	}
+
+	my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
+	return $sha1 eq $wt_sha1;
+}
+
 sub setup_dir_diff
 {
 	my ($repo, $workdir, $symlinks) = @_;
@@ -159,10 +174,10 @@ EOF
 		}
 
 		if ($rmode ne $null_mode) {
-			if ($rsha1 ne $null_sha1) {
-				$rindex .= "$rmode $rsha1\t$dst_path\0";
-			} else {
+			if (use_wt_file($repo, $workdir, $dst_path, $rsha1, $symlinks)) {
 				push(@working_tree, $dst_path);
+			} else {
+				$rindex .= "$rmode $rsha1\t$dst_path\0";
 			}
 		}
 	}
-- 
1.8.2.rc2.4.g7799588
