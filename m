From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: highlight: strip non-printable characters via col(1)
Date: Sat, 27 Aug 2011 00:06:18 +0200
Message-ID: <201108270006.19289.jnareb@gmail.com>
References: <1314053923-13122-1-git-send-email-cfuhrman@panix.com> <201108262154.14493.jnareb@gmail.com> <7v8vqfdf0l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Christopher M. Fuhrman" <cfuhrman@panix.com>, git@vger.kernel.org,
	Christopher Wilson <cwilson@cdwilson.us>,
	Sylvain Rabot <sylvain@abstraction.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 00:06:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx4Xq-0002EH-BO
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 00:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405Ab1HZWG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 18:06:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41491 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab1HZWG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 18:06:28 -0400
Received: by fxh19 with SMTP id 19so2892939fxh.19
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 15:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=OHcnHf+cqbPhrU9SO3xgH3flHCsTDU4pDt8IKw8ua8A=;
        b=ZwDGRxgasInJLX8bXnHcJ6nNtpc+G7csikhWQJm3zn1p00CiBRdg3MFxT5uRB/MQjc
         r00H4rEkfpDJiCfwYNSpVWlvb0YsyO62mW3VyZsySOZeIVmNBb+TGXjKQhONIYGju5Rz
         bt0chwlRtPrStx78O+ID0s1rX5YNcAfIRjRlc=
Received: by 10.223.88.214 with SMTP id b22mr588585fam.5.1314396387448;
        Fri, 26 Aug 2011 15:06:27 -0700 (PDT)
Received: from [192.168.1.13] (abwo191.neoplus.adsl.tpnet.pl [83.8.238.191])
        by mx.google.com with ESMTPS id 16sm1659456faw.42.2011.08.26.15.06.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Aug 2011 15:06:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v8vqfdf0l.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180205>

On Fri, 26 Aug 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Why use external program (which ming be not installed, or might not
> > strip control-characters), instead of making gitweb sanitize highlighter
> > output itself.  Something like the patch below (which additionally
> > shows where there are control characters):
> 
> I agree that that would be a more sensible approach. What does your sample
> code below do to a HT by the way?

Actually the line earlier

 			$line = untabify($line);

replaces HT ("\t") with spaces.

> > -- >8 --
> > diff --git i/gitweb/gitweb.perl w/gitweb/gitweb.perl
> > index 7cf12af..192db2c 100755
> > --- i/gitweb/gitweb.perl
> > +++ w/gitweb/gitweb.perl
> > @@ -1517,6 +1517,17 @@ sub esc_path {
> >  	return $str;
> >  }
> >  
> > +# Sanitize for use in XHTML + application/xml+xhtml
> > +sub sanitize {
> > +	my $str = shift;
> > +
> > +	return undef unless defined $str;
> > +
> > +	$str = to_utf8($str);
> > +	$str =~ s|([[:cntrl:]])|quot_cec($1)|eg;
> > +	return $str;
> > +}

Anyway, it could well be

+	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
+	return $str;

like in esc_html rather than like in esc_path.

> > @@ -6546,7 +6557,8 @@ sub git_blob {
> >  			$nr++;
> >  			$line = untabify($line);
                        ^^^^^^^^^^^^^^^^^^^^^^^^

> >  			printf qq!<div class="pre"><a id="l%i" href="%s#l%i" class="linenr">%4i</a> %s</div>\n!,
> > -			       $nr, esc_attr(href(-replay => 1)), $nr, $nr, $syntax ? to_utf8($line) : esc_html($line, -nbsp=>1);
> > +			       $nr, esc_attr(href(-replay => 1)), $nr, $nr,
> > +			       $syntax ? sanitize($line) : esc_html($line, -nbsp=>1);
> >  		}
> >  	}
> >  	close $fd

-- 
Jakub Narebski
Poland
