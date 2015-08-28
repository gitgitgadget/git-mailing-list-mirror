From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 2/4] path: optimize common dir checking
Date: Fri, 28 Aug 2015 14:36:47 -0400
Organization: Twitter
Message-ID: <1440787007.25570.0.camel@twopensource.com>
References: <1440618365-20628-1-git-send-email-dturner@twopensource.com>
	 <1440618365-20628-3-git-send-email-dturner@twopensource.com>
	 <xmqqwpwh21ky.fsf@gitster.dls.corp.google.com>
	 <1440627031.26055.5.camel@twopensource.com>
	 <1440627545.26055.8.camel@twopensource.com>
	 <xmqqoahr2wqj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:36:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVOWE-0000lL-Aw
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 20:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbbH1Sgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 14:36:50 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33736 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbbH1Sgt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 14:36:49 -0400
Received: by qkch123 with SMTP id h123so33340666qkc.0
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 11:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=CBcuoWbN6WrVBs5zc6SQkPIEwPT04CTW0awz/7qh+08=;
        b=Z7/LuCZOT+IQuFXUwKgwUEcXwuFZWyhUjpAwSTjqyZCFqNgo12ptvUkn3Qtrxpaejt
         PAzGGEZ2jjK5jjEY1I95hHsjJfqsgz41NdX+pUH4Rr5E1UK/FGkQoKqieIWxsMkcXKv+
         m0zlkoQ69zzd31UN5SHUZKH3USHCIyDtMo9ac3x8+/oU2ci1PiMmEwyn1mhSn2d+arAi
         iaYJadlwQPHIuONwv0yKTivG0fYL4b5P0gCiVf0qHhVnR1lJz7KYqkuzyR8+N50Neezw
         AJA9lzGLtuihvuo6gc00nB9Im2DF8G0BXyn+jeUw6g09UTNjNE8C+xXwaWB2PJ5mHr1n
         3DrQ==
X-Gm-Message-State: ALoCoQkx74hn97o7j2CzG+1vc1kwd+bO8o/+gB7b2iEWQTRdSepF6NRAMY4POxlEVTlav8siESgV
X-Received: by 10.55.56.198 with SMTP id f189mr17718185qka.79.1440787009000;
        Fri, 28 Aug 2015 11:36:49 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 132sm3912471qhx.28.2015.08.28.11.36.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2015 11:36:48 -0700 (PDT)
In-Reply-To: <xmqqoahr2wqj.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276748>

On Fri, 2015-08-28 at 09:39 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > On Wed, 2015-08-26 at 18:10 -0400, David Turner wrote:
> >> On Wed, 2015-08-26 at 14:15 -0700, Junio C Hamano wrote:
> >> > > + * For example, consider the following set of strings:
> >> > > + * abc
> >> > > + * def
> >> > > + * definite
> >> > > + * definition
> >> > > + *
> >> > > + * The trie would look look like:
> >> > > + * root: len = 0, value = (something), children a and d non-NULL.
> >> > 
> >> > "value = NULL", as there is no empty string registered in the trie?
> >> 
> >> Indeed.
> >> 
> >> > > + *    a: len = 2, contents = bc
> >> > 
> >> > "value = NULL" here, too (just showing I am following along, not
> >> > just skimming)?
> >> 
> >> Yep.
> >
> > No, wait. value should be non-NULL, since abc is in the string set. 
> 
> True.  Here is what I came up with on top of your original.  
> 
> 
> 
>  path.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/path.c b/path.c
> index 4100ba6..ce0530b 100644
> --- a/path.c
> +++ b/path.c
> @@ -133,12 +133,13 @@ struct common_dir common_list[] = {
>   * definition
>   *
>   * The trie would look look like:
> - * root: len = 0, value = (something), children a and d non-NULL.
> - *    a: len = 2, contents = bc
> - *    d: len = 2, contents = ef, children i non-NULL, value = (something)
> + * root: len = 0, children a and d non-NULL, value = NULL.
> + *    a: len = 2, contents = bc, value = (data for "abc")
> + *    d: len = 2, contents = ef, children i non-NULL, value = (data for "def")
>   *       i: len = 3, contents = nit, children e and i non-NULL, value = NULL
> - *           e: len = 0, children all NULL, value = (something)
> - *           i: len = 2, contents = on, children all NULL, value = (something)
> + *           e: len = 0, children all NULL, value = (data for "definite")
> + *           i: len = 2, contents = on, children all NULL,
> + *              value = (data for "definition")
>   */
>  struct trie {
>  	struct trie *children[256];

LGTM.
