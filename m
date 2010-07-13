From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: git-p4 move/delete errors
Date: Tue, 13 Jul 2010 13:22:40 +0200
Message-ID: <AANLkTimWeZq3yPo01Ytj-rfP5tY8k100kDHJX_eWRwUq@mail.gmail.com>
References: <AANLkTinN0Av1CO7mZU-QKeApq43UmEykUV093eyTtKQN@mail.gmail.com>
	<AANLkTikPHJuf5JUe096BWTWO_oF9u3gNlVNuw7Ik32WQ@mail.gmail.com>
	<AANLkTin7eMFXT1FwZ2ojcAYgqIMSYnkz-uCoRlHvV6Tm@mail.gmail.com>
	<F94DAB9A-A06D-46ED-9AAA-EDE850365054@gmail.com>
	<AANLkTilQtnIzNCcRzYzSqPEvXenHgND-_SAWmUeM64BH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tor Arvid Lund <torarvid@gmail.com>, git@vger.kernel.org
To: Lance Linder <llinder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 13:23:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYdZj-00065J-IA
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 13:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab0GMLWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 07:22:43 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35524 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab0GMLWm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 07:22:42 -0400
Received: by wwi17 with SMTP id 17so886705wwi.1
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 04:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=+b74O9RA/h5jhiGARkKlTndjswBpBIZyEs16km+vhMU=;
        b=ejUJ0FyeFeJRXWIAkF5+erN7VqzXnCGjR3cKqL0ycIqf/BqQ+UBmhVlwfArYjVjuTd
         Cciz1OkXFFxGfDmkpuZ4s7YDse2HZyzFiU629V5U8Gt/8gDs9/G1aOumgRkQr92eeSfo
         BJd9c8hK5E6nAWmvElxULp81tVsYSmXjBMQWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=IM85MVjF84S8zVdIQ0uW7cVpg7BnHoLAz5MBkP7K/2knU4EeVNax5Nxt+K9NWbdaoM
         wBg3i2kOChpXdOO0iU4EfyJro4zLs5mzQtcaALp6LsPKSWvBAzIa4VG3gllK6J3tECE+
         8g0vJbxpUd0dtM0BOXpmPXrlbtVrQla+YxMbI=
Received: by 10.227.154.9 with SMTP id m9mr6431311wbw.123.1279020160618; Tue, 
	13 Jul 2010 04:22:40 -0700 (PDT)
Received: by 10.216.45.205 with HTTP; Tue, 13 Jul 2010 04:22:40 -0700 (PDT)
In-Reply-To: <AANLkTilQtnIzNCcRzYzSqPEvXenHgND-_SAWmUeM64BH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150896>

On Fri, Jul 9, 2010 at 11:32 PM, Thomas Berg <merlin66b@gmail.com> wrote:

> Anyway, as far as I can see from the git-p4 source code, the command
> is only used to generate the diff preview in the interactive window
> that pops up when you "git p4 submit". So if you replace the line
> diff = p4_read_pipe("diff -du ...")
> with
> diff = ""
>
> it should start working again (the diff preview part will become
> empty). I'm unable to test it right now, but fairly sure it will work.
> I'll see if I can find a better solution when I have access to the
> Perforce server again.

It seems like they have done some bugfixes to "p4 diff -du ...", I
guess that's why we get different behaviour now. It prints the correct
output, but exits with an error code anyway when files have been
removed.

My solution is in the diff below. I'll run with it for a few days,
then I'll submit a proper patch to the mailing list (unless someone
else beat me to it).

Thomas

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index c1ea643..19f4519 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -706,7 +706,7 @@ class P4Submit(Command):
             submitTemplate = self.prepareLogMessage(template, logMessage)
             if os.environ.has_key("P4DIFF"):
                 del(os.environ["P4DIFF"])
-            diff = p4_read_pipe("diff -du ...")
+            diff = p4_read_pipe("diff -du ...", ignore_error=True)

             newdiff = ""
             for newFile in filesToAdd:
