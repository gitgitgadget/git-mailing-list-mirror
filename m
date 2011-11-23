From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH] run-command.c: Accept EACCES as command not found
Date: Wed, 23 Nov 2011 23:55:18 +0100
Message-ID: <op.v5e8mgbc0aolir@keputer>
References: <1321912387-4569-1-git-send-email-fransklaver@gmail.com>
 <7vbos5f7ix.fsf@alter.siamese.dyndns.org> <op.v5bjtk1r0aolir@keputer>
 <7v62idf2vy.fsf@alter.siamese.dyndns.org>
 <CAH6sp9MxbDhQ3RiA6jO1fswAZX3R6C2fv0gzJdpGp432ovWsjQ@mail.gmail.com>
 <CAH6sp9N2ycsoU=is3BVanH33CowD+sMNmWq=Z1MsPJX=HGYY+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 23 23:55:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTLiy-0003mT-MS
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 23:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079Ab1KWWzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 17:55:24 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59358 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801Ab1KWWzX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 17:55:23 -0500
Received: by faas1 with SMTP id s1so939989faa.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 14:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=xuMZ8XDfkRrKvyccsjaFjj2LCx0vm3jNgTsRCObdgdI=;
        b=ZuEtYah1Pj9YKh2K02MAIRbQGowYs53gtI8QkbCJAjew9abQeJatYoB1YRGTlejn08
         LUbSNpNEdO6I6+jNhBL1ZDLz5HMYXEm5H3kO2FYXDFQLgJ9DhoiFyKWGiFkIIJ4UjIut
         2ZJ6ts7slvC0wp3NO9lAE+W9LV94voHFO4pQ8=
Received: by 10.180.4.37 with SMTP id h5mr26022092wih.45.1322088921842;
        Wed, 23 Nov 2011 14:55:21 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id m30sm1265315wbo.14.2011.11.23.14.55.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Nov 2011 14:55:21 -0800 (PST)
In-Reply-To: <CAH6sp9N2ycsoU=is3BVanH33CowD+sMNmWq=Z1MsPJX=HGYY+g@mail.gmail.com>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185884>

On Wed, 23 Nov 2011 09:17:43 +0100, Frans Klaver <fransklaver@gmail.com>  
wrote:

> On Tue, Nov 22, 2011 at 10:31 AM, Frans Klaver <fransklaver@gmail.com>  
> wrote:
>
>> If git is going to do some diagnostics on why the execvp returned
>> EACCES, it can still give a few hints. Most of the more likely options
>> are then ruled out.
>
> If there are no objections, I'm going to cook up a patch that
>
> - Keeps the current behavior (bail on EACCES)
> - Adds a more helpful diagnostic message somewhat like libexplain's,
> but more terse and if possible with slightly more domain knowledge
> - Takes into account the notes made following
> http://article.gmane.org/gmane.comp.version-control.git/171838

So here be some tests I intend to use (based on t0061.3):

run_command reports EACCES, file permissions:
         cat hello-script >hello.sh &&
         chmod -x hello.sh &&
         test_must_fail test-run-command run-command ./hello.sh 2>err &&

         grep "fatal: cannot exec.*hello.sh" err


run_command reports EACCES, search path permisions:
         mkdir -p inaccessible &&
         PATH=$(pwd)/inaccessible:$PATH &&
         export PATH &&

         cat hello-script >inaccessible/hello.sh &&
         chmod 400 inaccessible &&
         test_must_fail test-run-command run-command hello.sh 2>err &&

         grep "fatal: cannot exec.*hello.sh" err &&
         grep "incorrect PATH entry" err


run_command reports EACCES, interpreter fails:
         cat incorrect-interpreter-script >hello.sh &&
         chmod +x incorrect-interpreter-script &&
         chmod -x someinterpreter &&
         test_must_fail test-run-command run-command ./hello.sh 2>err &&

         grep "fatal: cannot exec.*hello.sh" err &&
         grep "cannot execute interpreter" err


Possibly getting (over)ambitious on the interpreter test, but hey, gotta  
aim high.

If anybody has a test case that isn't covered, I'd be much obliged.

Frans
