From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: print list of valid tools with '--tool-help'
Date: Thu, 15 Mar 2012 16:18:00 -0700
Message-ID: <7v8vj1ihcn.fsf@alter.siamese.dyndns.org>
References: <1331850311-4620-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 00:18:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Jw7-0001Wx-R9
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 00:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032375Ab2COXSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 19:18:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34886 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032364Ab2COXSI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 19:18:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5169B7366;
	Thu, 15 Mar 2012 19:18:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qY5c3yBuWr1C7OCcTpxZ5zsKB1I=; b=THGy9e
	iD36YbmKCVtUw2D50FWvB0ybkpKQmU2qpPTprAe6GVeCC1vIZcWLQ/lbD4vRm3HZ
	PTZ0F76BwWjMlJOcX8m3J7Jm8Qm5EEwQ71P4OHcaqNcfjmqIe8tVTTOvcaRA5Ybj
	7lVoM1afdBF6X2kbovlbdj1Yt3idX8gTX0uwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gmY8duJUYXdEC2TOCxqcW9DurdfeDTm3
	AzI4TTdyDe19MMxt7rptpQ+Kz0WYsVH8ifU2BHnXC7VVzAtP8kcAg9d2CJ3A7rNF
	BKZqasD/E8ak4sxDvGjf4pdlYyrX7Xg9uT+JU7rIVb4aVFiCXH6Zgc/eZUMgHxy3
	rP9hW17uSZ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CDE87365;
	Thu, 15 Mar 2012 19:18:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC95D7363; Thu, 15 Mar 2012
 19:18:01 -0400 (EDT)
In-Reply-To: <1331850311-4620-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Thu, 15 Mar 2012 18:25:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C404594-6EF5-11E1-8C6A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193237>

Tim Henigan <tim.henigan@gmail.com> writes:

> @@ -100,6 +101,15 @@ sub generate_command
>  		if ($arg eq '-h') {
>  			usage();
>  		}
> +		if ($arg eq '--tool-help') {
> +			my $gitpath = Git::exec_path();
> +			print "'git difftool --tool=<tool>' may be set to one of the following:\n";
> +			for (glob "$gitpath/mergetools/*") {
> +				next if /defaults$/;
> +				print "\t" . basename($_) . "\n";
> +			}

As this topic to show list of tools dynamically has plenty of time to be
in the mainline (it will be post 1.7.10), I would suggest a follow-up
series to this patch to do things like the following (just thinking
aloud):

 - define a new entry point to these mergetools/ scriptlets, let's call
   it "cando".  An entry for mergetools/kompare might look like this:

        cando () {
                type kompare >/dev/null && test -n "$DISPLAY"
        }

   that would yield true only when kompare is available and $DISPLAY is
   set.

 - instead of dumping everything in $gitpath/mergetools/*, check if each
   tool says it can be used in the user's environment.

        for (glob "$gitpath/mergetools/*") {
                next unless can_run($_);
                print ...
        }
        ...

   and "can_run" may look like this:

        sub can_run {
                my ($script) = @_;
             my $cmd = ". '$script' && cando";
             system('sh', '-c', $cmd) == 0;
        }

 - perhaps show the result in columnar layout.
