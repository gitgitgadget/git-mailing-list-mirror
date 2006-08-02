From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: RE: [PATCH 8/10] Fix some minor warnings to allow -Werror.
Date: Wed, 2 Aug 2006 19:47:49 +0100
Message-ID: <001c01c6b664$27536740$c47eedc1@ramsay1.demon.co.uk>
References: <7vvepbvauo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 02 20:48:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Lkx-0001PJ-1S
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 20:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWHBSrn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 14:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWHBSrn
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 14:47:43 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:19972 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S932142AbWHBSrl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 14:47:41 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-36.mail.demon.net with smtp (Exim 4.42)
	id 1G8Lkm-000MLO-LX; Wed, 02 Aug 2006 18:47:37 +0000
To: "Junio C Hamano" <junkio@cox.net>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Importance: Normal
In-Reply-To: <7vvepbvauo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24665>


On Wed, 2006-08-02 at 8:46, Junio C Hamano wrote:
> 
> "Ramsay Jones" <ramsay@ramsay1.demon.co.uk> writes:
> 
> > diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> > index 3e40747..bb5e7b7 100644
> > --- a/builtin-mailinfo.c
> > +++ b/builtin-mailinfo.c
> > @@ -531,7 +531,8 @@ static int decode_b_segment(char *in, ch
> >  static void convert_to_utf8(char *line, char *charset)
> >  {
> >  #ifndef NO_ICONV
> > -	char *in, *out;
> > +	const char *in;
> > +	char *out;
> >  	size_t insize, outsize, nrc;
> >  	char outbuf[4096]; /* cheat */
> >  	static char latin_one[] = "latin1";
> 
> This kills the compilation with:
> 
> gcc -o builtin-mailinfo.o -c -O2 -Werror -ansi -pedantic -std=c99 
> -D_XOPEN_SOURCE=500 -D_BSD_SOURCE -Wall 
> -Wdeclaration-after-statement -g -DSHA1_HEADER='<openssl/sha.h>' 
> -DNO_STRLCPY builtin-mailinfo.c
> cc1: warnings being treated as errors
> builtin-mailinfo.c: In function 'convert_to_utf8':
> builtin-mailinfo.c:561: warning: passing argument 2 of 'iconv' 
> from incompatible pointer type
> 
> where the line 561 reads:
> 
> 	nrc = iconv(conv, &in, &insize, &out, &outsize);
> 

OK, so I get exactly the same if I don't make the indicated change!
The second param of iconv() must have changed from const char* to char*
at some point in the last six years.
Just ignore this.

> > diff --git a/diff.c b/diff.c
> > index 5a71489..81630c0 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -614,6 +614,7 @@ static void emit_binary_diff(mmfile_t *o
> >  	 * whichever is smaller.
> >  	 */
> >  	delta = NULL;
> > +	orig_size = 0;
> >  	deflated = deflate_it(two->ptr, two->size, &deflate_size);
> >  	if (one->size && two->size) {
> >  		delta = diff_delta(one->ptr, one->size,
> 
> This is not wrong per se, but is working around a stupid compiler that
> do not understand the dataflow.  orig_size is only used when
> delta is non NULL, and when delta is non NULL, the variable is
> always set.  Not very happy but is acceptable.
> 

Yes, you are absolutely correct. I agree it would be nice if gcc was
"fixed" so that it could detect this situation, but I'm not going to
hold my breath. It just seemed to be the lesser evil.

Ramsay
