From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Value size limits on git config files
Date: Tue, 05 Apr 2011 13:35:46 -0400
Message-ID: <1302024946.17813.57.camel@drew-northup.unet.maine.edu>
References: <BANLkTikknAiYr4y-it3+qZ3dnXE56dQBoQ@mail.gmail.com>
	 <BANLkTimLxPdr=mGJfxmdKkeq0zouxz05Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff Adamson <jwa@urbancode.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 05 19:36:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7AAp-00078s-A6
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 19:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126Ab1DERgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 13:36:13 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:59440 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991Ab1DERgH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 13:36:07 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p35HZpx9008639
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 5 Apr 2011 13:35:57 -0400
In-Reply-To: <BANLkTimLxPdr=mGJfxmdKkeq0zouxz05Uw@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=3
	Fuz1=3 Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p35HZpx9008639
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1302629757.84418@rzpYwgoVVRsgalwlcD829A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170894>


On Tue, 2011-04-05 at 19:01 +0200, Erik Faye-Lund wrote:
> On Tue, Apr 5, 2011 at 6:29 PM, Jeff Adamson <jwa@urbancode.com> wrote:
> I was
> > able to strip enough comments and such from myscript that it then no
> > longer invalidated the config once the value was less than 1024 chars.

> It's due to use of a fixed-size buffer. This patch fixes it for me:
> 
> diff --git a/config.c b/config.c
> index 0abcada..bc6ea49 100644
> --- a/config.c
> +++ b/config.c
> @@ -133,23 +133,20 @@ static int get_next_char(void)
> 
>  static char *parse_value(void)
>  {
> -	static char value[1024];
> -	int quote = 0, comment = 0, len = 0, space = 0;
> +	struct strbuf value = STRBUF_INIT;
> +	int quote = 0, comment = 0, space = 0;

Eric,
You're doing a lot more here than just making a simple char buffer
larger...

>  	for (;;) {
>  		int c = get_next_char();
> -		if (len >= sizeof(value) - 1)
> -			return NULL;
>  		if (c == '\n') {
>  			if (quote)
>  				return NULL;
> -			value[len] = 0;
> -			return value;
> +			return strbuf_detach(&value, NULL);

...ditto...

>  		}
>  		if (comment)
>  			continue;
>  		if (isspace(c) && !quote) {
> -			if (len)
> +			if (value.len)

...ditto...

>  				space++;
>  			continue;
>  		}
> @@ -160,7 +157,7 @@ static char *parse_value(void)
>  			}
>  		}
>  		for (; space; space--)
> -			value[len++] = ' ';
> +			strbuf_addch(&value, ' ');

...ditto...

(The rest cut for discussion...)

The the first question that needs to be asked is: Is there a reason why
it was still only 1kiB long?
The second is why adopt the struct here and not use an expanded char[]
element?

I'm not saying this is wrong by any means, but it is a lot more than
just a simple change in the length of a char buffer.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
