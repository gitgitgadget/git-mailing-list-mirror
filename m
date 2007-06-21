From: Michael Hendricks <michael@ndrix.org>
Subject: Re: [PATCH] git-send-email: RFC2822 compliant Message-ID
Date: Wed, 20 Jun 2007 22:09:30 -0600
Message-ID: <20070621040929.GE5915@ginosko.local>
References: <11823459011323-git-send-email-michael@ndrix.org> <7v7ipytkt5.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 06:09:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1DzD-0005q7-UI
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 06:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbXFUEJe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 00:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbXFUEJe
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 00:09:34 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43076 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750991AbXFUEJd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jun 2007 00:09:33 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 73DF2140C;
	Thu, 21 Jun 2007 00:09:32 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 21 Jun 2007 00:09:33 -0400
X-Sasl-enc: q7yBA863sSg9WWZMKDxtcn/+kuYMvsD1R3IJSTqu6ELc 1182398983
Received: from localhost (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTP id A4079303D;
	Thu, 21 Jun 2007 00:09:43 -0400 (EDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7ipytkt5.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50590>

On Wed, Jun 20, 2007 at 01:47:34PM -0700, Junio C Hamano wrote:
> How about doing this instead?
> 
>  * Move call to make_message_id() to where it matters, namely,
>    before the $message_id is needed to be placed in the
>    generated e-mail header; this has an important side effect of
>    making it clear that $from is already available.
> 
>  * Throw in Sys::Hostname::hostname() just for fun, although I
>    suspect that the code would never trigger due to the modified
>    call sequence that makes sure $from is always available.
> 
> ---
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 7c0c90b..9f75551 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -412,13 +412,21 @@ sub extract_valid_address {
>  # 1 second since the last time we were called.
>  
>  # We'll setup a template for the message id, using the "from" address:
> -my $message_id_from = extract_valid_address($from);
> -my $message_id_template = "<%s-git-send-email-$message_id_from>";
>  
>  sub make_message_id
>  {
>  	my $date = time;
>  	my $pseudo_rand = int (rand(4200));
> +	my $du_part;
> +	for ($from, $committer, $author) {
> +		$du_part = extract_valid_address($_);
> +		last if ($du_part ne '');
> +	}
> +	if ($du_part eq '') {
> +		use Sys::Hostname qw();
> +		$du_part = 'user@' . Sys::Hostname::hostname();
> +	}
> +	my $message_id_template = "<%s-git-send-email-$du_part>";
>  	$message_id = sprintf $message_id_template, "$date$pseudo_rand";
>  	#print "new message id = $message_id\n"; # Was useful for debugging
>  }
> @@ -467,6 +475,8 @@ sub send_message
>  		$ccline = "\nCc: $cc";
>  	}
>  	$from = sanitize_address_rfc822($from);
> +	make_message_id();
> +
>  	my $header = "From: $from
>  To: $to${ccline}
>  Subject: $subject
> @@ -533,7 +543,6 @@ X-Mailer: git-send-email $gitversion
>  
>  $reply_to = $initial_reply_to;
>  $references = $initial_reply_to || '';
> -make_message_id();
>  $subject = $initial_subject;
>  
>  foreach my $t (@files) {
> @@ -627,7 +636,6 @@ foreach my $t (@files) {
>  			$references = "$message_id";
>  		}
>  	}
> -	make_message_id();
>  }
>  
>  if ($compose) {
> 

I like it.  It eliminates two globals and makes the context of
make_message_id clearer.

-- 
Michael
