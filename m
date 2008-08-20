From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: git for-each-ref crashes for %(body) with tags
Date: Wed, 20 Aug 2008 17:41:49 -0300
Message-ID: <f329bf540808201341m183da990hef93d35c08773b86@mail.gmail.com>
References: <f329bf540808201128r2d21c40cr37eb63a6706ac0aa@mail.gmail.com>
	 <7vhc9fqz4a.fsf@gitster.siamese.dyndns.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:43:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVuWA-00039s-Gy
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757400AbYHTUlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757385AbYHTUlw
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:41:52 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:24678 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757243AbYHTUlv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:41:51 -0400
Received: by yx-out-2324.google.com with SMTP id 8so293419yxm.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 13:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/WJvTQAB3GIeePbMiLhYbtCVlV0qxw8tBRJta1IYTTk=;
        b=sgPftqkZmOyudI2mJOMPK3XnNKiil/nrRWmBR/nGyF6gfx194bCbdlzUle5NhYX3T+
         OYlPFlzYC7Mz9iR/rY49jDeWTLFGsF4K88wLsa5PPX8LYGeAACkfnk4X9cSEYJaYaPBt
         mOVSbaKwXm4ra24YCivk6cNttNdw1svinkYSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=CZrgWyip05OP02fKJWhMQFkgstt4pJ11lWuJDXeOjblZyBbYQu65DVHSs+9Y3WLZbF
         OBaru5NpVyWpw2k0sHA+3xCy/CBS0rZtvUi8j61i5u7tp00J/PEpr+6vDqyABzhaqgyy
         4yPTyhkh63BR5gwepXTu5R6C/D846zftHGbBA=
Received: by 10.114.192.17 with SMTP id p17mr755877waf.29.1219264909494;
        Wed, 20 Aug 2008 13:41:49 -0700 (PDT)
Received: by 10.115.109.8 with HTTP; Wed, 20 Aug 2008 13:41:49 -0700 (PDT)
In-Reply-To: <7vhc9fqz4a.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93042>

>From what I can see, the command responsible was

  git tag empty


it still works (v1.6.0):

$ git tag this-tag-has-no-body

$ git cat-file tag this-tag-has-no-body
fatal: git-cat-file this-tag-has-no-body: bad file

$ git cat-file commit this-tag-has-no-body |head -2
tree b51a1eb73af67d17f12114ed3e1e6f93d5adbaa8
parent 49e532412bbc84e4fb73f0862df61882dd7dbf89




On Wed, Aug 20, 2008 at 4:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Han-Wen Nienhuys" <hanwenn@gmail.com> writes:
>
>> see gdb trace below.   Unfortunately, I don't have a repo that I can
>> readily share to demonstrate this.
>
> You have a tag that has a single incomplete line as its payload.  The
> attached patch should fix it, but I wonder how you created such an unusual
> (I would not say "broken") tag to begin with?
>
>
> diff --git i/builtin-for-each-ref.c w/builtin-for-each-ref.c
> index 445039e..4d25ec5 100644
> --- i/builtin-for-each-ref.c
> +++ w/builtin-for-each-ref.c
> @@ -459,8 +459,10 @@ static void find_subpos(const char *buf, unsigned long sz, const char **sub, con
>                return;
>        *sub = buf; /* first non-empty line */
>        buf = strchr(buf, '\n');
> -       if (!buf)
> +       if (!buf) {
> +               *body = "";
>                return; /* no body */
> +       }
>        while (*buf == '\n')
>                buf++; /* skip blank between subject and body */
>        *body = buf;
>



-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
