From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: Cannot fetch whole history from Perforce
Date: Tue, 8 Mar 2011 23:33:21 +0100
Message-ID: <AANLkTimaB3BU3YQgC7qgqUH=qYGrthPxnz63b-MLAbCR@mail.gmail.com>
References: <AANLkTik6fxHUJbp6dWdAgV-wr=P=FxK1K-vGAGy8ruBd@mail.gmail.com>
	<AANLkTin6BBD+b2OYRk32GyAaEqFa-V7T1B7jEVujRkuL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Pete Wyckoff <pw@padd.com>
To: Thomas Berg <merlin66b@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 23:34:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px5To-0005pG-Bi
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 23:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828Ab1CHWeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 17:34:06 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64798 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab1CHWeF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 17:34:05 -0500
Received: by fxm17 with SMTP id 17so5611200fxm.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 14:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=9W+Un3yllls2Ij1OoRHTvgRRJqobotbgMGYAGdrO9O0=;
        b=jZAvidiFn8kll/FKTEMzsp23VM92p4qw7Na07uX/4O2Ixd5StuX/n958hpRJEA/gd9
         uEFniMAxTuJ1VPiDB6GsjUVgWOsGoCjR3fr8ZTwGmdjopt0BmAlKa8O4LJ0hyLeqwpkg
         3jgy7KnH6bu2zHA40OS6ltVnr7nst5gztOE3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qydMBptSoUTFu4KggaYEMt7vSi0cUa488Sl12fsLtZoHKoumsgFsR7peooE9QMoE9U
         24WbrITu/aghj9CoF1gNOCg+kgAw+HvnRzHExREaXxag3CMMMGmLFRXVU61duEh2tQC1
         l/lJ3mJhaXrw2Sk4ZvEAyg9sSX86Zt9tUCT6o=
Received: by 10.223.143.86 with SMTP id t22mr4464588fau.81.1299623601979; Tue,
 08 Mar 2011 14:33:21 -0800 (PST)
Received: by 10.223.151.16 with HTTP; Tue, 8 Mar 2011 14:33:21 -0800 (PST)
In-Reply-To: <AANLkTin6BBD+b2OYRk32GyAaEqFa-V7T1B7jEVujRkuL@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168711>

On Tue, Mar 8, 2011 at 9:36 PM, Thomas Berg <merlin66b@gmail.com> wrote:
> Hi,
>
> On Tue, Mar 8, 2011 at 7:09 PM, Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
>> Hi, I am using HEAD version of the git and I have an issue with git-p4
>> tool (p4 to git importer).
>>
>> git-p4 works fine when I import HEAD version of my project
>>
>> $ git p4 clone //depot/foo/bar --verbose
>> But it fails with a cryptic error when I try to import @all revisions:
> [...]
>>
>> $ git p4 clone //depot/foo/bar@all --verbose
>> Importing from //depot/foo/bar@all into bar
> [...]
>>
>> Can it be related to Pete's changes?
>> http://permalink.gmane.org/gmane.comp.version-control.git/167281

Whoops! The P4Clone class is a subclass of P4Sync, which means that
this check (The one you mention from e32e00dc) will be done on every
clone with @all. We can't have that :)

It works for me if I patch it with this one-liner (but it's not
exactly a beautiful looking line of code anymore):

    -- Tor Arvid
---

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2df3bb2..7cb479c 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1763,7 +1763,7 @@ class P4Sync(Command):

                 changes.sort()
             else:
-                if not self.p4BranchesInGit:
+                if not isinstance(self, P4Clone) and not self.p4BranchesInGit:
                     die("No remote p4 branches.  Perhaps you never
did \"git p4 clone\" in here.");
                 if self.verbose:
                     print "Getting p4 changes for %s...%s" % (',
'.join(self.depotPaths),
