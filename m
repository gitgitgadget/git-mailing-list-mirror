From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [RFC] Design for pathname encoding gitattribute [RESEND]
Date: Mon, 21 Jan 2008 23:43:58 -0800
Message-ID: <7vr6gatidd.fsf@gitster.siamese.dyndns.org>
References: <20080122050215.DE198200A2@wilber.wgtn.cat-it.co.nz>
	<7vlk6iv0ik.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Jan 22 08:44:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHDoN-0005Fy-TS
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 08:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbYAVHoS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jan 2008 02:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbYAVHoS
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 02:44:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbYAVHoR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 02:44:17 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 278BA6FD4;
	Tue, 22 Jan 2008 02:44:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A4866FD3;
	Tue, 22 Jan 2008 02:44:05 -0500 (EST)
In-Reply-To: <7vlk6iv0ik.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 21 Jan 2008 22:26:43 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71425>

Junio C Hamano <gitster@pobox.com> writes:

> Sam Vilain <sam.vilain@catalyst.net.nz> writes:
>
>> Some projects may like to enforce a particular encoding is used for
>> all filenames in the repository.  Within the UTF-8 encoding, there a=
re
>> four normal forms (see http://unicode.org/reports/tr15/), any of whi=
ch
>> may be a reasonable repository format choice.  Additionally, some
>> filesystems may have a single encoding that they support when writin=
g
>> local filenames.  To support this, iconv and a normalization library
>> must have the information they need to perform the correct conversio=
n.
>
> Isn't there a chicken-and-egg problem?  The attributes are by
> nature per-path, and you need to match the pathname string with
> a pattern to decide which attribute definition to apply to a
> given path.  Before knowing what encoding the pathname you have
> just read from readdir(3), how would you match that pathname
> with the pattern in the gitattributes file?
>
> I can buy the .git/config (and an in-tree .git-encoding,
> perhaps), though.

I admit that Documenta=C3=A7=C3=A3o/ja/=E3=81=8A=E8=AA=AD=E3=81=BF=E4=B8=
=8B=E3=81=95=E3=81=84 example was contrived
(the last component is README-in-Japanese), and if anybody still
wanted to have such a tree sanely, the only practical
cross-platform and multi-language way to do so is to have
everything in UTF-8 at the repository level.

In that sense, the project does not need to specify anything,
other than marking that "all of the pathnames in tree objects
are in UTF-8 (we could go stronger, and say which kind of
normalization we want)".  As there is no other practical choice
than UTF-8-NFC if you want to be cross-platform, compatible, and
multi-language, the project can just declare that is what it
uses and does not have to mark it any specially.

A particular clone of such a project may want to check
everything out as-is to get an UTF-8 only tree (I'll mention
HFS+ shortly).  Another clone may want to get mixed legacy
encodings by running mkdir(utf8_to_latin1("Documenta=C3=A7=C3=A3o")) an=
d
creat(utf8_to_eucjp(" =E3=81=8A=E8=AA=AD=E3=81=BF=E4=B8=8B=E3=81=95=E3=81=
=84")), but that is purely a
local matter and should not be controlled by anything in-tree,
be it .gitattributes or .git-encoding.

On the other hand, it is not so unusual to see a legacy encoding
used in the pathnames, especially if your project does not need
to deal with multi-language issues.  In such a repository, I do
not want to enforce that all the paths in tree objects MUST be
UTF-8.  If all the project participant agree to work with EUC-JP
pathnames in tree objects, we should not make the users always
go through double conversion going from readdir(3) to index, and
coming from index back to open(2) or creat(2).  Again, that is
done by agreement by project participants, so there is nothing
that needs to be specified in-tree.

If the project uses UTF-8-NFC, we would need to adjust check-in
and check-out codepath like Linus's readdir(3) hack suggested,
but that needs to be done only on HFS+.  Of course, the project
participants need to be careful not to create files that HFS+
cannot handle (two paths that happen to be equivalent strings
should not be created), but I do not think that is such a big
issue as some people seem to make a big deal out of.  If you
want to be interoperable with different filesystems, you should
not create two paths that are different only in case, and if
there are participants who are on such a filesystem, the mistake
is quickly spotted and corrected.  It happened in git.git to a
file other than that infamous M=C3=A4rchen.  It's exactly the same
issue [*1*].

In short, initially I did not like Linus's readdir(3) hack very
much, but the more I think about it, I like it the better.

We pick a reasonable default (i.e. "no conversion") at the
technical level, and recommend (but do not pay for the overhead
of enforcing) a reasonable normalization as the BCP at the human
level.  Only on filesystems that mangle the pathnames, or if you
want legacy encodings on the filesystem, we would need to pay
overhead for conversion and help people with actual code to do
so.

To support the above scenarios, I think each instance of
repository needs to be able to say "this path (specified with a
matching pattern in the filename encoding) should be converted
this way coming in, and that way going out."  UTF-8 only project
would have NKC<->NKD on HFS+ partition, and nothing on
everywhere else.  EUC-JP project that checks out as-is would
specify nothing either, but people on Shift_JIS platforms would
locally specify that EUC-JP <-> Shift_JIS conversion to be made.


[Footnote]

*1* This is an important point, especially the breakage was
about tests that used files "a" and "A".  No pathname
enforcement in git-as-scm would have enforced anything to avoid
the breakage.  But there are humans involved in the project and
they are an integral part of ensuring interoperability.
