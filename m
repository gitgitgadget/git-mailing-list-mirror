X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 1/n] gitweb: Better git-unquoting and gitweb-quoting of pathnames
Date: Fri, 03 Nov 2006 00:15:39 -0800
Message-ID: <7vlkmtgd3o.fsf@assigned-by-dhcp.cox.net>
References: <200610301953.01875.jnareb@gmail.com>
	<200610301958.23334.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 08:15:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610301958.23334.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 30 Oct 2006 19:58:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30794>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfuDH-0005a1-Ru for gcvg-git@gmane.org; Fri, 03 Nov
 2006 09:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751151AbWKCIPl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 03:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWKCIPl
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 03:15:41 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:51630 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1751151AbWKCIPk
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 03:15:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103081540.LAER2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Fri, 3
 Nov 2006 03:15:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id i8Fk1V00M1kojtg0000000 Fri, 03 Nov 2006
 03:15:45 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ec46b80..a15e916 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -563,12 +563,42 @@ sub esc_html {
>  	return $str;
>  }
>  
> +# quote unsafe characters and escape filename to HTML
> +sub esc_path {
> +	my $str = shift;
> +	$str = esc_html($str);
> +	$str =~ s/[[:cntrl:]\a\b\e\f\n\r\t\011]/?/g; # like --hide-control-chars in ls
> +	return $str;
> +}
> +

When you say "[:cntrl:]" do you need to say anything more?

I was initially puzzled by "\t\011" bit, but I realize that is a
bug that is consistent with the next part I'll comment on.

>  # git may return quoted and escaped filenames
>  sub unquote {
>  	my $str = shift;
> +
> +	sub unq {
> +		my $seq = shift;
> +		my %es = (
> +			't' => "\t", # tab            (HT, TAB)
> +			'n' => "\n", # newline        (NL)
> +			'r' => "\r", # return         (CR)
> +			'f' => "\f", # form feed      (FF)
> +			'b' => "\b", # backspace      (BS)
> +			'a' => "\a", # alarm (bell)   (BEL)
> +			#'e' => "\e", # escape        (ESC)
> +			'v' => "\011", # vertical tab (VT)
> +		);
> +
> +		# octal char sequence
> +		return chr(oct($seq))  if ($seq =~ m/^[0-7]{1,3}$/);
> +		# C escape sequence (this includes '\n' (LF) and '\t' (TAB))
> +		return $es{$seq}       if ($seq =~ m/^[abefnrtv]$/);

Problems in this part of the code X-<.

 * Was there a reason not to unwrap '\e' to "\e"?

 * The vertical tab is \013 (decimal 11), not \011 (which is TAB).

 * The name and the abbreviated name of the character "\n" are
   "line feed" and "LF"; I personally do not think these
   character name comments are needed in this part of the code,
   but I do not object if you want to have them there, as long
   as you spell them correctly. cf. ISO/IEC 6429:1992 or
   http://www.unicode.org/charts/PDF/U0000.pdf for example.

 * The hash %es and the pattern /[abef...]/ must be kept in
   sync; it is a maintenance nightmare,

 * Worse yet, they do not agree even in this initial version,
   which proves the previous point.

Perhaps this is better written as:

	if (exists $es{$seq}) {
        	return $es{$seq};
	}

The rest must have been a lot of work to sift through esc_html
and identify which is path and which is not.  Much appreciated
and expect a cleaned up patch to be applied.
