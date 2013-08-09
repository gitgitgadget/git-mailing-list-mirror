From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 2/2] remote-hg: add shared repo upgrade
Date: Fri, 9 Aug 2013 22:19:56 +0200
Message-ID: <CALWbr2yAitLSNGj2qwz4C8Ugm8wHnGTf4ndZSbPcFToczWaWEA@mail.gmail.com>
References: <1376078581-24766-1-git-send-email-felipe.contreras@gmail.com>
	<1376078581-24766-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	=?UTF-8?Q?J=C3=B6rn_Hees?= <dev@joernhees.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 22:20:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7tAJ-0003HJ-7x
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 22:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031028Ab3HIUT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 16:19:58 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:39668 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031006Ab3HIUT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 16:19:57 -0400
Received: by mail-qa0-f44.google.com with SMTP id hu16so65621qab.10
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 13:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OiTYARNo8oqIkIopObrOsl84mdnlTxtAClRQDBHZ4OI=;
        b=E6dAEgpmJNugChy7jlpGLjPwiKd/IH8LjjkSqOjV2CXKYxDOCsQNnmB+Jm3DFQFPKT
         ddyhSfFPP1zLoRxzkesxHE3E24QKvU2Ye82KzD7Lj5UxkUqaUIPXMKxnIlRzfrPFIblz
         K041stKVhQVhC6acoF2f9vuZUrqkYlNgrMHi9bk10eyLo9pgZmrAD96DFzY7fCBWdzW5
         5a/mBC6zs18xyRGUGe00APz4Uqo6kPgcLBv0Y+7CLq5vq45yYBxVFmmdiCaUNNuDpY65
         ei2eY/NCskojMfg7k08a0FhF/tZwxZOlAlXBkWI5p9QZlhAggcauUNO0UledYz6anI9l
         hVgQ==
X-Received: by 10.224.76.71 with SMTP id b7mr13104810qak.48.1376079596695;
 Fri, 09 Aug 2013 13:19:56 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Fri, 9 Aug 2013 13:19:56 -0700 (PDT)
In-Reply-To: <1376078581-24766-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232024>

On Fri, Aug 9, 2013 at 10:03 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> 6796d49 (remote-hg: use a shared repository store) introduced a bug by
> making the shared repository '.git/hg', which is already used before
> that patch, so clones that happened before that patch, fail after that
> patch, because there's no shared Mercurial repo.

Does that still hold ? You are creating the shared_path repository
just below, so it should work without the patch.
The real reason for this patch is to avoid having to re-clone from a
potential slow source, is it not ?

> +        # check and upgrade old organization
> +        hg_path = os.path.join(shared_path, '.hg')
> +        if os.path.exists(shared_path) and not os.path.exists(hg_path):
> +            repos = os.listdir(shared_path)
> +            for x in repos:
> +                local_hg = os.path.join(shared_path, x, 'clone', '.hg')
> +                if not os.path.exists(local_hg):
> +                    continue
> +                shutil.copytree(local_hg, hg_path)
> +                break
> +

By the way, I liked my version better, that is:

if os.path.exists(local_hg):
    shutil.copytree(local_hg, hg_path)
    break

Simplifying the if not condition: continue else: break

>          # setup shared repo (if not there)
>          try:
>              hg.peer(myui, {}, shared_path, create=True)
