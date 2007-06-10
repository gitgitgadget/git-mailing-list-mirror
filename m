From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Silence error messages unless 'thorough_verify' is set
Date: Sun, 10 Jun 2007 07:48:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100741310.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vwsydf1m8.fsf@assigned-by-dhcp.cox.net> <200706092028.54459.johan@herland.net>
 <200706092142.05446.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 08:51:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxHHE-0000xy-F9
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 08:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759616AbXFJGvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 02:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759553AbXFJGvv
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 02:51:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:37226 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758057AbXFJGvu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 02:51:50 -0400
Received: (qmail invoked by alias); 10 Jun 2007 06:51:48 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp046) with SMTP; 10 Jun 2007 08:51:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+09VUoM+C0Xc4iLxaECCrtnEyADb+7ZDez+CVzmB
	ZvaNu9LOFXlr9t
X-X-Sender: gene099@racer.site
In-Reply-To: <200706092142.05446.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49655>

Hi,

On Sat, 9 Jun 2007, Johan Herland wrote:

> +#define FAIL(...) ( thorough_verify ? error(__VA_ARGS__) : -1 )
> +
>  	unsigned char sha1[20];
>  	char type[20];
>  	const char   *type_line, *tag_line, *keywords_line, *tagger_line;
> @@ -80,26 +82,26 @@ int parse_and_verify_tag_buffer(struct tag *item,
>  	}
>  
>  	if (size < 65)
> -		return error("Tag object failed preliminary size check");
> +		return FAIL("Tag object failed preliminary size check");

This is ugly.

If you _have_ to output the error message in one case, and not in the 
other, I'd rather do

	enum tag_error { TAG_SIZE_CHECK, TAG_BLA_BLUB, ... };
	const char **tag_error_strings = { "tag: size error", ... };

Of course, you'd lose the ability to output some numbers. But those 
numbers that you output are even uglier than the code. Guess how surprised 
_I_ was, when I hit the error message which made me go mad.

Having said that, I still do not agree in this unifying.

Your rationale seems to be: use the same checking for the tag creation as 
for the tag validation.

But this is _wrong_. We _do_ have tags that do not conform to the strict 
standards of git-tag, and even if we did _not_, it would _still_ be wrong 
to be that strict when _reading_ tags.

To drive that point home: strict checking when creating tags is good. 
Strict checking when reading tags is bad.

I strongly encourage keeping both validations separate.

You'd also avoid having that many lines which are well over the encouraged 
80 character limit.

Ciao,
Dscho
