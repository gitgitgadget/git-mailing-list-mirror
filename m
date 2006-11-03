X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 1/n] gitweb: Better git-unquoting and gitweb-quoting of pathnames
Date: Fri, 3 Nov 2006 11:59:01 +0100
Message-ID: <200611031159.02065.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com> <200610301958.23334.jnareb@gmail.com> <7vlkmtgd3o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 10:59:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZlXhdhdNMGXV4NFW7MdJWhz43n3X85BBU6ee7cag42CtfCyDd935Qs3mjLp0FQc5zweFnOI2gTWFJ8YXMRnbRn/dHa8n+b1bUZO408YMz+s3rgCWWR+dQkcHYFZWmm3SxQXrwod/9/F2L/Jw7CzgNQZK+h/yrVYXFzdLlyl9ZEM=
User-Agent: KMail/1.9.3
In-Reply-To: <7vlkmtgd3o.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30824>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfwlF-0008WD-NE for gcvg-git@gmane.org; Fri, 03 Nov
 2006 11:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753213AbWKCK6y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 05:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753214AbWKCK6y
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 05:58:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:29723 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1753213AbWKCK6y
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 05:58:54 -0500
Received: by ug-out-1314.google.com with SMTP id m3so372826ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 02:58:52 -0800 (PST)
Received: by 10.66.243.4 with SMTP id q4mr2475119ugh.1162551532770; Fri, 03
 Nov 2006 02:58:52 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 53sm739131ugn.2006.11.03.02.58.52; Fri, 03 Nov
 2006 02:58:52 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index ec46b80..a15e916 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -563,12 +563,42 @@ sub esc_html {
> >  	return $str;
> >  }
> >  
> > +# quote unsafe characters and escape filename to HTML
> > +sub esc_path {
> > +	my $str = shift;
> > +	$str = esc_html($str);
> > +	$str =~ s/[[:cntrl:]\a\b\e\f\n\r\t\011]/?/g; # like --hide-control-chars in ls
> > +	return $str;
> > +}
> > +
> 
> When you say "[:cntrl:]" do you need to say anything more?

Ooops. Yes, the \a\b\e\f\n\r\t\011 part is redundant.

> >  # git may return quoted and escaped filenames
> >  sub unquote {
> >  	my $str = shift;
> > +
> > +	sub unq {
> > +		my $seq = shift;
> > +		my %es = (
> > +			't' => "\t", # tab            (HT, TAB)
> > +			'n' => "\n", # newline        (NL)
> > +			'r' => "\r", # return         (CR)
> > +			'f' => "\f", # form feed      (FF)
> > +			'b' => "\b", # backspace      (BS)
> > +			'a' => "\a", # alarm (bell)   (BEL)
> > +			#'e' => "\e", # escape        (ESC)
> > +			'v' => "\011", # vertical tab (VT)
> > +		);
> > +
> > +		# octal char sequence
> > +		return chr(oct($seq))  if ($seq =~ m/^[0-7]{1,3}$/);
> > +		# C escape sequence (this includes '\n' (LF) and '\t' (TAB))
> > +		return $es{$seq}       if ($seq =~ m/^[abefnrtv]$/);
> 
> Problems in this part of the code X-<.
> 
>  * Was there a reason not to unwrap '\e' to "\e"?

It was not mentioned in description of git pathname quoting in the
message
  http://marc.theaimsgroup.com/?l=git&m=112927316408690&w=2;

>  * The vertical tab is \013 (decimal 11), not \011 (which is TAB).

Oops. ASCII 11 is decimal 11.

>  * The name and the abbreviated name of the character "\n" are
>    "line feed" and "LF"; I personally do not think these
>    character name comments are needed in this part of the code,
>    but I do not object if you want to have them there, as long
>    as you spell them correctly. cf. ISO/IEC 6429:1992 or
>    http://www.unicode.org/charts/PDF/U0000.pdf for example.

Perhaps it should be "LF ('\n') and TAB ('\t')".

>  * The hash %es and the pattern /[abef...]/ must be kept in
>    sync; it is a maintenance nightmare,
> 
>  * Worse yet, they do not agree even in this initial version,
>    which proves the previous point.
> 
> Perhaps this is better written as:
> 
> 	if (exists $es{$seq}) {
>         	return $es{$seq};
> 	}

Fact.

Or
	return $es{$seq} if exists $es{$seq};

-- 
Jakub Narebski
