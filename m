From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: parse all messages in mbox
Date: Tue, 12 May 2009 16:27:21 -0700
Message-ID: <7vpred7vhi.fsf@alter.siamese.dyndns.org>
References: <873abbeoqc.wl%vmayatsk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vitaly Mayatskikh <v.mayatskih@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 01:29:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M41PF-00062l-JG
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 01:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757790AbZELX1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 19:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755908AbZELX1i
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 19:27:38 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:53956 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754130AbZELX1g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 19:27:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090512232728.WSVB2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 12 May 2009 19:27:28 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id qnTS1b00E4aMwMQ04nTSEJ; Tue, 12 May 2009 19:27:26 -0400
X-Authority-Analysis: v=1.0 c=1 a=wutGvft0F3MA:10 a=hzVDzittV6kA:10
 a=pGLkceISAAAA:8 a=t3VdCCvr3hf0j-X7IqAA:9 a=Fwd3xO8hV02tKk7NsTgA:7
 a=pcKqLl4YCm-PdHGKrXiJMifQynEA:4 a=MSl-tDqOz04A:10 a=ZBK95DTRNC9ASMUz:21
 a=aCE1zepKotSUmeJ_:21
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118972>

Vitaly Mayatskikh <v.mayatskih@gmail.com> writes:

> Currently git-send-email sends all mbox in one email. This seems to be wrong,
> because mbox can contain several messages. For example,
> `git format-patch --stdout' forms mbox file with all patches in it.
>
> This patch allows git send-email to send several messages from one mbox
> separately.

I suspect nobody would comment on it because with reindentation this was
extremely painful to review.

I _think_ the gist of your change is that (1) here you stop slurping the
body when you see a line that begins with "From "...

> +		# Now parse the message body
> +		while(<F>) {
> +			last if /^From /; # Next message in file

... and (2) the "last unless (<F>)" at the end of the loop where you
attempt to see if there is any more lines to be read from the stream (and
if so go back and continue from the header parsing).

> -	# set up for the next message
> -	if ($chain_reply_to || !defined $reply_to || length($reply_to) == 0) {
> -		$reply_to = $message_id;
> -		if (length $references > 0) {
> -			$references .= "\n $message_id";
> -		} else {
> -			$references = "$message_id";
> +		# set up for the next message
> +		if ($chain_reply_to || !defined $reply_to || length($reply_to) == 0) {
> +			$reply_to = $message_id;
> +			if (length $references > 0) {
> +				$references .= "\n $message_id";
> +			} else {
> +				$references = "$message_id";
> +			}
>  		}
> +		$message_id = undef;
> +		last unless (<F>);
>  	}
> -	$message_id = undef;
> +	close F;

But I think the code structure is wrong.  When you said "last if /^From /"
earlier, you have already read that line (and you do not unread it), and
here with "unless (<F>)" you are reading yet another line (one line after
the UNIX-From line) and discarding it.  The next round loses the real
RFC2822 header line you discarded with this unless (<F>), and begins from
the next line, and would break "First unfold multiline header fields"
logic among other things.

But this is only from reviewing a patch with reindentation noise so I
might have missed some subtle issues.

Can you make this into two patches for easier review?  One to split out
the existing loop for a single input stream into a helper function without
changing any behaviour (i.e. the loop reads everything to the end), and
then as a follow-up patch introduce "when we see a UNIX-From line we are
at the beginning of the next message so return early" logic to the helper?

IOW, after the two-patch series, the current main-loop may look
something like:

	my $unread_line = undef;
	while (1) {
		$unread_line = handle_one_stream(\*F, $unread_line);
                last if (!defined $unread_line);
	}
        close(\*F);

and your new handle_one_stream() sub will look something like:

	sub handle_one_stream {
		my ($fh, $last_line) = @_;
		local ($_);

		my $author = undef;
                my $author_encoding;
                my $has_content_type;
                my $body_encoding;
                @cc = ();
                @xh = ();
                my $input_format = undef;
                my @header = ();
                $message = "";
                $message_num++;

                # First unfold multiline header fields
                while (1) {
			if (defined $last_line) {
				$_ = $last_line;
                                $last_line = undef;
			} else {
                        	$_ = <F>;
			}
                        ...
		}
                # Now parse the header
                ...
                # Now parse the message body
                $last_line = undef;
                while (1) {
                	$_ = <F>;
			if (/^From /) {
				# This is the beginning of the
                                # next message; unread it.
				$last_line = $_;
                                last;
                        }
                        $message .= $_;
			...
		}
		return $last_line;
	}
