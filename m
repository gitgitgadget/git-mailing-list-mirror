X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Fri, 3 Nov 2006 23:33:49 +0100
Message-ID: <200611032333.49794.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com> <200611031719.13073.jnareb@gmail.com> <7virhw5hoi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 22:33:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iUhrSoDpC1xZw6d73pJHVLqGLGJbwTQp4MHbciIUz3REEb8Y4ozvOtd+YI6MfsUkoPB1sFA7X2Wxk9qBC9mngFiYV5TS0tbT7Acxg+HOMcIW81clA+g1TSPTQvi1PmGBk94QOuTYKXtrJOkpfGgjsgusGU+ynDkzM86OU3Y6le8=
User-Agent: KMail/1.9.3
In-Reply-To: <7virhw5hoi.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30890>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg7bQ-0006Oe-Rs for gcvg-git@gmane.org; Fri, 03 Nov
 2006 23:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932208AbWKCWd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 17:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWKCWd3
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 17:33:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:64016 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S932208AbWKCWd3
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 17:33:29 -0500
Received: by ug-out-1314.google.com with SMTP id m3so531736ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 14:33:27 -0800 (PST)
Received: by 10.67.22.7 with SMTP id z7mr3484954ugi.1162593207427; Fri, 03
 Nov 2006 14:33:27 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 39sm1403006ugb.2006.11.03.14.33.26; Fri, 03 Nov
 2006 14:33:27 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> # quote unsafe characters and escape filename to HTML
>> sub esc_path {
>> 	my $str = shift;
>> 	$str = esc_html($str);
>> 	$str =~ s!([[:cntrl:]])!sprintf('<span 
class="cntrl">&#%04d;</span>', 9216+ord($1))!eg;
>> 	return $str;
>> }
>>
>> with perhaps the following CSS
>>
>> span.cntrl {
>> 	border: dashed #aaaaaa;
>> 	border-width: 1px;
>> 	padding: 0px 2px 0px 2px;
>> 	margin:  0px 2px 0px 2px;
>> }
>>
>> What do you think of it?
> 
> Probably "# quote unsafe characters" is not what it does yet (it
> just quotes controls currently and nothing else), but we have to
> start somewhere and I think this is a good start.

Well, control characters (at least some of them) are not correct
characters in UTF-8 HTML output; Mozilla in strict XHTML mode complains.
Currently for example esc_html escapes FORM FEED (FF) and ESCAPE (ESC)
characters, because they happened to be present in git.git repository
(in COPYING file and in commit v1.4.2.1-g20a3847 respectively).

As I see it, we can either replace non-safe characters (control
characters) by single characters a la --hide-control-chars: that
is minimal solution, or we can quote unseafe characters somewhat,
but if we do that we have to indicate that we quote. Git core and
ls encloses material which needs escaping with quotes; in gitweb
it is somewhat impractical; besides we have more possibilities
to mark fragment of text (span element encompassing representation
of escaped characters for example).

I have thought of the following escaping:

1. Hide control characters using '?' or other similar character like
   &cdot; for example
2. Use "Unicode" quoting, i.e. replace control characters by their
   Unicode Printable Representation (PR), as shown above. Has the
   advantage that it is simple and does not need theoretically marking
   that it is quoted; has the disadvantage that browser must support
   this part of Unicode, and that those characters are less than
   readable with default font size gitweb uses.
3. Use Character Escape Codes (CEC), using alphabetic and octal
   backslash sequences like those used in C. Probably need to escape
   backslash (quoting character) too. Has the advantage of being widely
   understood in POSIX world. Has the disadvantage of need for escape
   sequence table/hash. Has the advantage that it works for all
   characters - simple octal backslash sequence if they have no special
   escape sequence.
4. Control key Sequence (CS), like the one used in esc_html currently,
   replacing control characters by key sequence that produces them,
   for example replacing LF with ^J, CR with ^M, FF with ^L, ESC with
   ^[, TAB with ^I. Has the advantage of being undestodd I think in
   MS-DOS/MS WIndows world. Has the advantage of being used in esc_html.
   Has the advantage that some text editors use this representation.
   Has the disadvantage of need for large key sequence table/hash.
   Has the disadvantage that less common control characters have cryptic
   control key sequences.
5. Percent encoding, also know as URL encoding. Use %<hex> encoding used
   in URL, taken for example from core of esc_url/esc_param subroutine.
   Simple, but does need marking that is escaped. Disadvantage of hardly
   readable.

Which solution do you think it's best? Or perhaps other solution, like 
using Unicode Printable Representation, or Character Escape Codes with 
the exception of LF which would be replaced by &para; (paragraph sign), 
RET by &crarr; and TAB by either &thorn;, &#8614; or &rarr;.

-- 
Jakub Narebski
