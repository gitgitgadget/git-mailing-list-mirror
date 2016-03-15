From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 04/19] index-helper: new daemon for caching index and
 related stuff
Date: Tue, 15 Mar 2016 18:52:30 +0700
Message-ID: <CACsJy8BxDZg93ssBZGcC7Jsm_LpDgRtHUBfCm0agbvkPX9hUHw@mail.gmail.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com> <1457548582-28302-5-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 12:53:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afnXB-0000Ec-Bd
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 12:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934298AbcCOLxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 07:53:05 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33411 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378AbcCOLxB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 07:53:01 -0400
Received: by mail-lb0-f170.google.com with SMTP id oe12so19172822lbc.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 04:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+RAoy9KSRxNXkuTL3TrWewbzVrnHP5ckBr6laFtdlJQ=;
        b=ekLKP/zCATCn/19ep1GHe7D7+Rlj3k2aArPTyNROloSxXQfc8TRMvqA+mYoFIjskcW
         PfWigxGuGwehG4RLg57bHwkENQ1PZwthQSG3mJb2PLPwzjiZGRDPx7UCIsXk0KQrFs1w
         P37nyMxZyYaA2WYOtTmQ2huX8fGHQfV4kA6FTYVH5vk7mjPwBgB2hQZ5KBYIUNhThzA6
         QvFITppkRnF6ouMbZ7FDMX7sFyioCr8UUoQpj2SdMbzazjY0pwV/5xlzVlgdoJl5fy9R
         dyTAOvhjrqXIxWKTuz1eoSaLuUF0Ew3yLep5qKtfCrJNgUnLpWImtp32N5LfE7dUiEKu
         w/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+RAoy9KSRxNXkuTL3TrWewbzVrnHP5ckBr6laFtdlJQ=;
        b=PxmBBMQAF58v3SMHTmILMCTx9dNfYLRMrvyfqkGso2zi8JX8BWsVR8v7qrp0Gzqoi6
         AaFxDCtqWGvsBfHNPfWmG9nbHqz/vNcY1wImr+wWk6PqV4GRwL5TexxwvYRyqwLNW7ik
         VmYhm/BW2XxTumkIqUcdRO/VLUlFnZ3/wcyoWtJrmhKwEsljTAuejjZCclMAbmsV7EXs
         xg0lZSW4HeSnGkyoaSlQfAyoymWk55OVLtGp0WdMYqcnqVSlNXk0qootrTEVgWpYKc9s
         9Y4YlOuP4+Bn/mtx5l5zpDf26WnX9OjVBr6g/pb49/m9gGTpwYmgePKt0N9s1ganZQVN
         6riA==
X-Gm-Message-State: AD7BkJJyfMmJjuAiEh7W8LK3Ed++CGrvQ1pN3/4i/cmdCK3mGFjT7tUrz5ySf5mWswPdF0zbjPJdOJf5in/qNg==
X-Received: by 10.25.159.68 with SMTP id i65mr9647471lfe.94.1458042780235;
 Tue, 15 Mar 2016 04:53:00 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 15 Mar 2016 04:52:30 -0700 (PDT)
In-Reply-To: <1457548582-28302-5-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288849>

On Thu, Mar 10, 2016 at 1:36 AM, David Turner <dturner@twopensource.com> wrote:
> Git can poke the daemon to tell it to refresh the index cache, or to
> keep it alive some more minutes via UNIX signals.

The reason I went with UNIX signals was because it made it possible to
make a simple GetMessage loop, the only thing I can remember from my
Windows time, on Windows later. It sounded clever, but because this is
more like UDP (vs TCP) it's harder for communication. For example, we
can't get a confirmation after a request... UNIX sockets would be more
natural.

Since this patch was written, watchman has gained Windows support. I
just looked at the code, it uses named pipe on Windows. So maybe we
can just go with that too (if only because it has been proven working
in practice) and we can go back to UNIX sockets on the *nix side. Too
bad we can't just copy some functions from watchman because of license
incompatibility. But we can leave Windows support to gfw team now, I
think.
-- 
Duy
