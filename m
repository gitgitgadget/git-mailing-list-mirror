From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Strip non-printable characters from syntax highlighter output
Date: Fri, 16 Sep 2011 20:58:49 +0200
Message-ID: <201109162058.51132.jnareb@gmail.com>
References: <1314053923-13122-1-git-send-email-cfuhrman@panix.com> <201109161441.58946.jnareb@gmail.com> <7vwrd8fnxr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Christopher M. Fuhrman" <cfuhrman@panix.com>, git@vger.kernel.org,
	Christopher Wilson <cwilson@cdwilson.us>,
	Sylvain Rabot <sylvain@abstraction.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 20:59:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4dcu-0000E4-8R
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 20:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108Ab1IPS67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 14:58:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34325 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab1IPS66 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 14:58:58 -0400
Received: by fxe4 with SMTP id 4so1956917fxe.19
        for <git@vger.kernel.org>; Fri, 16 Sep 2011 11:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=x3pYGOjRxnzrCdb6qwxhsI4rLzlhhnhLSyo4C92UxZU=;
        b=KIGehgodEOsX4QxYiMGYU4JZNOfU0ut2vpl8cIfGuK/HEz1A4eO6Qa9UjiQHfTrYe/
         3J1uL4bhlDcSbCg49xysLIi74C+9WxuYAvvFHevigbX60gpj/5XID8EbwOKD9yP4w6mB
         gcmaxoxVi+luNha/WRHL15NndDY07osjifMz8=
Received: by 10.223.18.73 with SMTP id v9mr358917faa.70.1316199537714;
        Fri, 16 Sep 2011 11:58:57 -0700 (PDT)
Received: from [192.168.1.13] (abvu156.neoplus.adsl.tpnet.pl. [83.8.218.156])
        by mx.google.com with ESMTPS id r3sm11524990fam.26.2011.09.16.11.58.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Sep 2011 11:58:56 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vwrd8fnxr.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181543>

On Fri, 16 Sep 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:

> Micronit:
> 
> > +# Sanitize for use in XHTML + application/xml+xhtm (valid XML 1.0)
> > +sub sanitize {
> > +	my $str = shift;
> > +
> > +	return undef unless defined $str;
> 
> Given that the _whole_ point of this subroutine is to make $str safe for
> printing, wouldn't you want to either (1) die, declaring that feeding an
> undef to this subroutine is a programming error, or (2) return an empty
> string?

Well, that

	return undef unless defined $str;

line is copy'n'paste (as is most of sanitize() body) from esc_html().
This line was added in 1df4876 (gitweb: Protect escaping functions against
calling on undef, 2010-02-07) with the following explanation

    This is a bit of future-proofing esc_html and friends: when called
    with undefined value they would now would return undef... which would
    probably mean that error would still occur, but closer to the source
    of problem.
    
    This means that we can safely use
      esc_html(shift) || "Internal Server Error"
    in die_error() instead of
      esc_html(shift || "Internal Server Error")

So actually now I see that while this line is good to have in esc_html(),
it is not really necessary in sanitize().

But anyway we don't want to replace undef with an empty string; undef is
(usually) an error, and we want to catch it, not to hide it.
 
> Given that the input to this function is from the result of feeding $line
> to untabify, which relies on $line being defined, and that $line comes
> from "while (my $line = <$fd>)" (and then chomp $line), it may be Ok for
> this subroutine to make the same assumption as untabify makes.

Right.

Passing undef to sanitize() is usually an error, and we don't want to hide
it.  We want for gitweb test to detect it.

-- 
Jakub Narebski
Poland
