From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git merge conflicts and encoding of logs
Date: Tue, 23 Dec 2008 00:22:08 -0800
Message-ID: <7vprjjfgi7.fsf@gitster.siamese.dyndns.org>
References: <87lju7h4yb.dancerj%dancer@netfort.gr.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: Junichi Uekawa <dancer@netfort.gr.jp>
X-From: git-owner@vger.kernel.org Tue Dec 23 09:23:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF2YC-0003ub-T8
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 09:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbYLWIWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 03:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbYLWIWS
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 03:22:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbYLWIWR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 03:22:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3FC1F1AE5F;
	Tue, 23 Dec 2008 03:22:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A30761AE5E; Tue,
 23 Dec 2008 03:22:11 -0500 (EST)
In-Reply-To: <87lju7h4yb.dancerj%dancer@netfort.gr.jp> (Junichi Uekawa's
 message of "Tue, 23 Dec 2008 13:48:44 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CECCDE92-D0CA-11DD-8A65-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103803>

--=-=-=
Content-Type: text/plain; charset=iso-2022-jp

Junichi Uekawa <dancer@netfort.gr.jp> writes:

> Git merge conflict will insert '<<< first line of commit log message'
> '===' '>>>' markers to the text file that is causing a conflict.
>
> Unfortunately, the encoding of the text file may be different from the
> log message encoding, and that results in a file which has a mixed
> encoding (which is pretty hard to edit from any editor BTW).
>
> My use case is editing platex files (iso-2022-jp encoded) with log
> messages of utf-8.
>
> ... Thinking about it, it's probably the same encoding problem as git
> blame.

What 69cd8f6 (builtin-blame: Reencode commit messages according to git-log
rules., 2008-10-22) does to git-blame is to re-encode the data taken from
the commit log to i18n.logoutputencoding, and put that in the datastream.

If your commit object have names and messages in utf-8, and if you set
i18n.logoutputencoding to iso-2022-jp, that would reencode data taken from
the commit object in iso-2022-jp and sprinkle them in the blame
datastream.

The issue would be certainly similar, *if* anything on your <<</===/>>>
lines came from commit log message, but I couldn't trigger what you
describe.  I prepared a history of this shape:

   B
  /
 o---A

with ISO-2022-JP payload and UTF-8 commit log message.  Then, I added:

        [i18n]
                logoutputencoding = iso-2022-jp

which lets me read "git log -p --all" quite comfortably.  Everything comes
out as good old JISX0208.  So far, so good.

Then while on branch B, I tried to merge A, which resulted in conflicts
that looked like this:

<<<<<<< HEAD:foo
これはサイドブランチの変更です。
やはり JIS コードで書いてます。
=======
日本語のファイルです。
JIS コードで書いてます。
>>>>>>> master:foo

The above will probably come out as UTF-8 in this mail text, but the point
is that the confict side markers do not have anything but filename and the
branch name.  I am still scratching my head trying to see where in the
merge-recursive codepath you got snippet of log message.

A bundle from my test repository is attached.  You can use it to reproduce
the repository like this:
 
    $ cd /var/tmp && mkdir test && cd test && git init
    $ git pull ../x.bndl master
    $ git fetch ../x.bndl side:side


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=x.bndl
Content-Transfer-Encoding: base64
Content-Description: a bundle of the sample history

IyB2MiBnaXQgYnVuZGxlCjQzYjk0NzQ2ZTU4ODNjMTA3MjcwZTM1NGJmYTc5ZjNmZGY1NjdlOWYg
cmVmcy9oZWFkcy9tYXN0ZXIKZTBiMjZjODA2NjM3NzNmM2U0NzhjOGFjMDYxMjMwMGE3YTE0ZDdi
NiByZWZzL2hlYWRzL3NpZGUKClBBQ0sAAAACAAAACZUQeJydyz1OwzAYgOHdp/guQPX5N7aEEBJL
6coJ/AsZElfBlRibdKETEmthQ2JjgYGB21jNOegZur563jLECMi0MKpBKZ1KgYVkWOJaqMiV9yKE
JonIKUWytkPsC3iH2gotKA1MJEMxMaa48ToY55pIaQxMaqmI3ZSHPMBq07cZbmBpO9tnuLxvy2OJ
w/U6u/y08Lm7Aso4IjWSIVygRiSn2rXlpM66yfy2PT6/1/Hr+LGfDz91eoXV7R3U6bvu/upuX8fP
+fBbx5e6ncg/iUlbR/UGQ7lHRuWIPBBycONUv6efP99Wfp94nAFlAJr/hQL3AS10cmVlIDgwZDIx
M2FmMWQ4ZGE5N2Y5ODgwN2JmMDA4NTJiMTY4OTJjNjY0YzWRLWMCNzmRkjwpNzkgLTA4MDAKCuOC
teOCpOODieODluODqeODs+ODgeOBruWkieabtApfCScgkgt4nJ3LXQpCIRBA4XdXMRsoZnRChYgg
iGgX5k/5oHPxeqHld9fQ6+E7c+QMnE4lhhS1N8Gwy84Va22K6DUWomyTJWaKKmzzIwOeW68CN3iE
FrrA+V3nOvO4LvKS7zFKuwBpg0ieHcMBHaLaa6tzV3/d6l7HOkF6Vj8eTTYSrwF4nDM0MDAzMVFI
y89nWLHdunj3i+KlXpv4RcL87NXXrDvYAgCqpQwkswV4nJNWcVIxVslR8Vc1VVVR9VQNU81ULVZ1
VPHzCrS0VHFXsVRUltZw4pIGKktR8VfJAnIUvDyDFYACqsaKNqqeKu62hSoqKm4qcTC1ANQpEOSv
AXicMzQwMDMxUUjLz2c4dSmm56L9/hvft/+tOfIjP+hZfZISANAQD0y8A3ick1ZxcqvxjrHIUfFT
DVVVVFVRzVZxV7FUVJbWcOLy8gxWkFZxUjVWtFH1VHG3LVRRUXFTiYNJAwCPdAxcrwF4nDM0MDAz
MVFIy89neDb30exNF685e3drriuPunHoSU/wRADG7Q6cMHicAwAAAAABHfgkiRyNyDstRgoZTRUH
BDqJgGw=
--=-=-=--
