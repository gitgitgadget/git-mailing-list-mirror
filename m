From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Wed, 30 Jan 2013 10:03:28 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87vcae90hr.fsf@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 16:04:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0ZCo-0008ED-AH
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 16:04:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990Ab3A3PDo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jan 2013 10:03:44 -0500
Received: from plane.gmane.org ([80.91.229.3]:45273 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669Ab3A3PDn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 10:03:43 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1U0ZCf-0008AN-Ai
	for git@vger.kernel.org; Wed, 30 Jan 2013 16:03:57 +0100
Received: from c-65-96-148-157.hsd1.ma.comcast.net ([65.96.148.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 16:03:57 +0100
Received: from tzz by c-65-96-148-157.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 16:03:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-65-96-148-157.hsd1.ma.comcast.net
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:tBqSChBQkH+SlU4liBW43KhHQHY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215024>

On Tue, 29 Jan 2013 11:53:19 -0800 Junio C Hamano <gitster@pobox.com> w=
rote:=20

JCH> Makes one wonder why .authinfo and not .netrc;=20

JCH> http://www.gnu.org/software/emacs/manual/html_node/auth/Help-for-u=
sers.html

JCH> phrases it amusingly:

JCH>         =E2=80=9CNetrc=E2=80=9D files are usually called .authinfo=
 or .netr
JCH>         nowadays .authinfo seems to be more popular and the
JCH>         auth-source library encourages this confusion by accepting
JCH>         both

I wrote this and the auth-source.el library in Emacs (I'm glad it was
amusing :).  The confusion is further perpetuated by our (in Emacs)
encouragement to use a .authinfo.gpg file, which is then decrypted on
the fly by Emacs through GPG.  The format is the same; by the time
auth-source.el sees the contents, they are plain text since the decodin=
g
happens at the file handler level.

I think it makes sense to write the code to support both
`git-send-email' and credentials.  I have had it in my TODO list for
almost 2 years now to work on credential support, and to support the
~/.authinfo.gpg decoding specifically.  Ideally this would also support
the other formats... Michal, would you be interested in that feature?  =
I
promise to get off my rear and help out.

>> +The '~/.authinfo' file is read if Text::CSV Perl module is installe=
d
>> +on the system; if it's missing, a notification message will be prin=
ted
>> +and the file ignored altogether.  The file should contain a line wi=
th
>> +the following format:
>> ++
>> +  machine <domain> port <port> login <user> password <pass>

JCH> It is rather strange to require a comma-separated-values parser to
JCH> read a file format this simple, isn't it?

I'd recommend a hand-crafted parser.  Among other things, you should
accept both "strings" and 'strings' if possible (I've seen both formats
in the wild), and the format is simple enough to avoid the module
dependency.

>> ++
>> +Contrary to other tools, 'git-send-email' does not support symbolic
>> +port names like 'imap' thus `<port>` must be a number.

JCH> Perhaps you can convert at least some popular ones yourself?  Afte=
r
JCH> all, the user may be using an _existing_ .authinfo/.netrc that she
JCH> has been using with other programs that do understand symbolic por=
t
JCH> names.  Rather than forcing all such users to update their files,
JCH> the patch can work a bit harder for them and the world will be a
JCH> better place, no?

I agree, "port imap" is a nice self-documenting token.  Maybe it can be
interpreted by the program that requests the token with a services
lookup, where supported.

Ted
