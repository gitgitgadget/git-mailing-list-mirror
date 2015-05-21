From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl: Add sendmail aliases support
Date: Thu, 21 May 2015 13:19:47 -0700
Message-ID: <xmqqioblisyk.fsf@gitster.dls.corp.google.com>
References: <3f1091c3de6e4e62037bc3c84c69026e33ee9707.1432229888.git.allenbh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 22:19:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvWwd-0004SL-Gx
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 22:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875AbbEUUTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 16:19:50 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34871 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755792AbbEUUTt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 16:19:49 -0400
Received: by igbyr2 with SMTP id yr2so19681757igb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 13:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qbglI6NhKyu97i0LIUU8HOrzEUNHG3lOBv3XjXE2XmQ=;
        b=Wc0UHpH4V6zHGeyHbT5hkBI6LHW0VugBJJRL4JdWtMi+9Mvdty+IqEYEbI6f5KxXQS
         aKgXJyk4wdfzT359ujid0SVkYGLV++EdQVuy+7odhX3Bhzb76o7w+TIzzpUkHCVhozt3
         ZYPqWD7gf+34md5foVuhHJQDDth2WEmakfyYus+I8WQkHqK8G49CE2c/dTupli8JYVQ1
         HdIrmh6dacjnZcYvputSNrj5yjaZAK5FNF4Xp5r+BbFZsZZqas3g9Hcu1GXREJDMRGU+
         9nnNPZ7FngaKzSihApj9wGBYuJmW2qIDDmBiMRvor2YUGaskYLutabTPU26aX59MA42D
         glkw==
X-Received: by 10.107.157.130 with SMTP id g124mr5923958ioe.11.1432239589332;
        Thu, 21 May 2015 13:19:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id c10sm12241799ioe.25.2015.05.21.13.19.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 13:19:48 -0700 (PDT)
In-Reply-To: <3f1091c3de6e4e62037bc3c84c69026e33ee9707.1432229888.git.allenbh@gmail.com>
	(Allen Hubbe's message of "Thu, 21 May 2015 14:51:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269653>

Allen Hubbe <allenbh@gmail.com> writes:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index e1e9b14..5f2ec0d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -515,7 +515,12 @@ my %parse_alias = (
>  			       $aliases{$alias} = [ split_addrs($addr) ];
>  			  }
>  		      } },
> -
> +	sendmail => sub { my $fh = shift; while (<$fh>) {
> +		next if /^$|^#|^\s/;
> +		if (/^(\S+)\s*:\s*(.*?)\\?$/) {
> +			my ($alias, $addr) = ($1, $2);
> +			$aliases{$alias} = [ split_addrs($addr) ];
> +		}}},

Let me unfold the line only to make commenting it easier.

	sendmail => sub {
        	my $fh = shift;
                while (<$fh>) {
			next if /^$|^#|^\s/;
			if (/^(\S+)\s*:\s*(.*?)\\?$/) {
				my ($alias, $addr) = ($1, $2);
				$aliases{$alias} = [ split_addrs($addr) ];
			}
		}
	},

It is probably OK to omit support for folded lines, but wouldn't it
be easy enough to be a bit more helpful to give a warning when you
find such lines in the input?  Otherwise you will leave the users
wondering why some of their aliases work while others don't.

Perhaps like this (this is not even an output from "diff" but typed
in my MUA, so there may be typos---take it just as illustrating
ideas)?

That way, users can fold the input themselves and try again if they
wanted to.  The warning _may_ have to be squelched after a few hits
to keep the result usable, though.

	sendmail => sub {
        	my $fh = shift;
                while (<$fh>) {
-			next if /^$|^#|^\s/;
-			if (/^(\S+)\s*:\s*(.*?)\\?$/) {
+			next if /^$|^#/;
+			if (/^\s/ || /\\$/) {
+				print STDERR "$.: $_";
+				print STDERR "continuation lines in alias not supported\n";
+				next;
+			}
+			if (/^(\S+)\s*:\s*(.*)$/) {
				my ($alias, $addr) = ($1, $2);
				$aliases{$alias} = [ split_addrs($addr) ];
			}
		}
	},

Thanks.
