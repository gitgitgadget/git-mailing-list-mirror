From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC][StGit PATCH] Add support for merge-friendly branches
Date: Thu, 28 May 2009 15:51:20 +0100
Message-ID: <b0943d9e0905280751k3b9f26c9gd907a7c11ca9d5e2@mail.gmail.com>
References: <20090528111212.21925.45527.stgit@pc1117.cambridge.arm.com>
	 <20090528124817.GA22262@diana.vm.bytemark.co.uk>
	 <b0943d9e0905280738n51476ab7vd0498ea7a236c4a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu May 28 16:52:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9gxb-0000RB-28
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 16:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776AbZE1OvV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 10:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbZE1OvU
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 10:51:20 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:60555 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764AbZE1OvU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 10:51:20 -0400
Received: by ewy24 with SMTP id 24so5464443ewy.37
        for <git@vger.kernel.org>; Thu, 28 May 2009 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=srEwmK8zFRgiBPZxHU5+8iGTOevsxYfTSHpB81PQjf4=;
        b=jQAvq+zkSKOjX5Rtc3QOyfDhTJDCRBv2pcKLzdVPJaOy94FZ016mfEf+Rz+p9l8Tc/
         1pMKMQfiibe+3SUPDHflbrveawICjzILnEHwMdwtyHfRbvDyfxAurisOLjD2O1CL6bSd
         bpyQ1iQXVl1Q/tIiybuIpBUr+3q4/0theALdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=suJ3gmhz3s/LD/6VdosSr/TPGCdh66agWL7gKUtvCGNsb788Hj5kzBDO5RnCIJOHMp
         2pw94CsDriP7YR8zD8VxcRiWNpEzcbB5lwj6EOYX1wQQhWxU/Pk8/+7OqZj5FBe5/b8E
         2u4mlgaWeXk4wbmRdpE8jxb8Sckzcm1WSNtL4=
Received: by 10.216.37.79 with SMTP id x57mr518954wea.160.1243522280318; Thu, 
	28 May 2009 07:51:20 -0700 (PDT)
In-Reply-To: <b0943d9e0905280738n51476ab7vd0498ea7a236c4a7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120191>

2009/5/28 Catalin Marinas <catalin.marinas@gmail.com>:
> 2009/5/28 Karl Hasselstr=F6m <kha@treskal.com>:
>> On 2009-05-28 12:12:42 +0100, Catalin Marinas wrote:
>>> + =A0 =A0def get_merge_base(self, commit1, commit2):
>>> + =A0 =A0 =A0 =A0"""Return the merge base of two commits."""
>>> + =A0 =A0 =A0 =A0sha1 =3D self.run(['git', 'merge-base',
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 commit1.sha1, com=
mit2.sha1]).output_one_line()
>>> + =A0 =A0 =A0 =A0return self.get_commit(sha1)
>>
>> This funcion should probably return a list of zero or more merge
>> bases. See the --all flag to git merge-base.
>
> OK, I'll add this and check the stack base against this set(list).

What about this change to the original patch (it's faster to just
return the sha1 refs than building the Commit objects):


diff --git a/stgit/commands/publish.py b/stgit/commands/publish.py
index 06c32d0..ce08a19 100644
--- a/stgit/commands/publish.py
+++ b/stgit/commands/publish.py
@@ -106,8 +106,8 @@ def func(parser, options, args):

     # check for rebased stack. In this case we emulate a merge with th=
e stack
     # base by setting two parents.
-    merge_base =3D repository.get_merge_base(public_head, stack.base)
-    if merge_base.sha1 !=3D stack.base.sha1:
+    merge_base =3D set(repository.get_merge_base_sha1(public_head, sta=
ck.base))
+    if not stack.base.sha1 in merge_base:
         public_head =3D __create_commit(repository, stack.head.data.tr=
ee,
                                       [public_head, stack.base], optio=
ns)
         repository.refs.set(public_ref, public_head, 'publish')
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 4a17c8a..5bd4e4d 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -609,11 +609,10 @@ class Repository(RunWithEnv):
             raise DetachedHeadException()
     def set_head_ref(self, ref, msg):
         self.run(['git', 'symbolic-ref', '-m', msg, 'HEAD', ref]).no_o=
utput()
-    def get_merge_base(self, commit1, commit2):
-        """Return the merge base of two commits."""
-        sha1 =3D self.run(['git', 'merge-base',
-                         commit1.sha1, commit2.sha1]).output_one_line(=
)
-        return self.get_commit(sha1)
+    def get_merge_base_sha1(self, commit1, commit2):
+        """Return the merge base of two commits as a list of sha1 refs=
=2E"""
+        return self.run(['git', 'merge-base', '--all',
+                         commit1.sha1, commit2.sha1]).output_lines()
     def simple_merge(self, base, ours, theirs):
         index =3D self.temp_index()
         try:

--=20
Catalin
