From: josh robb <josh_robb@fastmail.fm>
Subject: [patch] git svn slowness on win32
Date: Tue, 16 Feb 2010 23:04:04 +1300
Message-ID: <13237f021002160204o3c8af7a6i3e7105bd6bc43fa3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e64ea79e8b05ba047fb4daa5
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 11:04:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhKHv-0000z7-2L
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 11:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851Ab0BPKEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 05:04:09 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:51646 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756833Ab0BPKEH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 05:04:07 -0500
Received: by pzk17 with SMTP id 17so4879387pzk.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 02:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=OYYqA1y+uaDBR1buu8eYNRjxKbZTmamUZPLWPb3NuuA=;
        b=Bt+ArJNFo2CHFoGBwQXAGWgDdW0Ex3lUv8QqR0udZSmi2qqdXXrZn6QYmly19z/AQa
         ynZgd4JmhIopN3qHskfuW6pljzvudlNPR2UrfqHgjyircSvUZYAWiKFmqHxq4VQ/wCkg
         85aEnqY5PqsXMMM2MmrW5OhpItrHvyjK42syE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=Ho14KSyXRJ3UNVPRbwNBlg6DEoPTBNuyL5V7OH5cfVlX4CInXgJIWDZU4U4ujpY9wI
         KVBjBvR6rw1i9r6M1V8ZF3tmPtsEh249rBE9n7UKUzwV8ahRrA4ob8+5E/B4F9RyiOLI
         Zk0sIa1T5mLZSV6n6eS/wNeQoO5b9XbnCJsss=
Received: by 10.115.117.7 with SMTP id u7mr463996wam.178.1266314644227; Tue, 
	16 Feb 2010 02:04:04 -0800 (PST)
X-Google-Sender-Auth: a2cbfb85664c72dc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140089>

--0016e64ea79e8b05ba047fb4daa5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I'm using git svn (1.6.4.msysgit.0) within a WindowsXP VM running
under VMWare fusion on OSX 10.5. For me (and at least one other person
I know) git svn has been unbearably slow.

My profiling shows that almost all of the git-svn runtime is being
spent in DynaLoader (via SVN::Base::import) which I guess is slow in a
virtualized windows environment. For example:

$ time perl /libexec/git-core/git-svn rebase
Current branch master is up to date.

real 2m56.750s
user 0m3.129s
sys 2m39.232s

I've been able to make=A0significant=A0(an order of=A0magnitude)
improvements to it's performance by delaying SVN::Base::import from
running until it's actually needed.=A0After making this change:

$ time perl /libexec/git-core/git-svn rebase
Current branch master is up to date.

real 0m33.407s
user 0m1.409s
sys 0m23.054s

git svn rebase -n goes from 3m7.046s to 0m10.312s.

Would love to get some feedback/thoughts etc...

j.

--0016e64ea79e8b05ba047fb4daa5
Content-Type: text/plain; charset=US-ASCII; name="git-svn.patch.txt"
Content-Disposition: attachment; filename="git-svn.patch.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5qiwjnk0

LS0tIGdpdC1zdm4ub3JpZwlXZWQgSnVsIDI5IDIyOjU1OjI2IDIwMDkKKysrIGdpdC1zdm4JRnJp
IERlYyAgNCAxMzozODo1MiAyMDA5CkBAIC0yNywxMSArMjcsMTMgQEAKICR8ID0gMTsgIyB1bmJ1
ZmZlciBTVERPVVQKIAogc3ViIGZhdGFsIChAKSB7IHByaW50IFNUREVSUiAiQF9cbiI7IGV4aXQg
MSB9Ci1yZXF1aXJlIFNWTjo6Q29yZTsgIyB1c2UoKS1pbmcgdGhpcyBjYXVzZXMgc2VnZmF1bHRz
IGZvciBtZS4uLiAqc2hydWcqCi1yZXF1aXJlIFNWTjo6UmE7Ci1yZXF1aXJlIFNWTjo6RGVsdGE7
Ci1pZiAoJFNWTjo6Q29yZTo6VkVSU0lPTiBsdCAnMS4xLjAnKSB7Ci0JZmF0YWwgIk5lZWQgU1ZO
OjpDb3JlIDEuMS4wIG9yIGJldHRlciAoZ290ICRTVk46OkNvcmU6OlZFUlNJT04pIjsKK3N1YiBf
cmVxX3N2biB7CisJcmVxdWlyZSBTVk46OkNvcmU7ICMgdXNlKCktaW5nIHRoaXMgY2F1c2VzIHNl
Z2ZhdWx0cyBmb3IgbWUuLi4gKnNocnVnKgorCXJlcXVpcmUgU1ZOOjpSYTsKKwlyZXF1aXJlIFNW
Tjo6RGVsdGE7CisJaWYgKCRTVk46OkNvcmU6OlZFUlNJT04gbHQgJzEuMS4wJykgeworCQlmYXRh
bCAiTmVlZCBTVk46OkNvcmUgMS4xLjAgb3IgYmV0dGVyIChnb3QgJFNWTjo6Q29yZTo6VkVSU0lP
TikiOworCX0KIH0KIG15ICRjYW5fY29tcHJlc3MgPSBldmFsIHsgcmVxdWlyZSBDb21wcmVzczo6
WmxpYjsgMX07CiBwdXNoIEBHaXQ6OlNWTjo6UmE6OklTQSwgJ1NWTjo6UmEnOwpAQCAtNDM3OSw2
ICs0MzgxLDggQEAKIAlteSAoJGNsYXNzLCAkdXJsKSA9IEBfOwogCSR1cmwgPX4gcyEvKyQhITsK
IAlyZXR1cm4gJFJBIGlmICgkUkEgJiYgJFJBLT57dXJsfSBlcSAkdXJsKTsKKworCTo6X3JlcV9z
dm4oKTsKIAogCVNWTjo6X0NvcmU6OnN2bl9jb25maWdfZW5zdXJlKCRjb25maWdfZGlyLCB1bmRl
Zik7CiAJbXkgKCRiYXRvbiwgJGNhbGxiYWNrcykgPSBTVk46OkNvcmU6OmF1dGhfb3Blbl9oZWxw
ZXIoX2F1dGhfcHJvdmlkZXJzKTsK
--0016e64ea79e8b05ba047fb4daa5--
