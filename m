From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/9 v12] difftool: teach difftool to handle directory
 diffs
Date: Thu, 12 Apr 2012 11:27:10 -0700
Message-ID: <7viph46c1t.fsf@alter.siamese.dyndns.org>
References: <1334236726-18393-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com,
	ramsay@ramsay1.demon.co.uk
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 20:27:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIOkB-0003EX-Kr
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 20:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933910Ab2DLS1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 14:27:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53791 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933835Ab2DLS1O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 14:27:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0BB67178;
	Thu, 12 Apr 2012 14:27:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gT8+OKostMVePr8ESWruEqrmfqA=; b=V+W7Di
	i2oMVsqveEt6JZsIle3VRv+u7uomo3/c3Bj1TUKSLR5ymhqHVbzYE3WcKRb4q3/i
	3GBAodF0QllZAq06afdnN4OQzThZypvMABSwerJWAZNjR1dUIncCDudXXd0TCXg3
	uAPvGR49uF6jYx5ahIkjKAlZollDnOu3VMAq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LRWlKSPcJmD/gJmUXlM9Kyl9aUoOZXCe
	OWvSLAHLqd/wskbwarm2yTAGLJZGYNL16iTYwmvGcf2YO5l8rveHbU453XaYvhlZ
	QnFf9tji97daTJ1j76vvgqnZ8/l8bKDrgyTHOLLaLNt6XzcfXg1qYYC0tZrwVaXU
	0zDQukbVZGM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A70367177;
	Thu, 12 Apr 2012 14:27:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 395D67176; Thu, 12 Apr 2012
 14:27:13 -0400 (EDT)
In-Reply-To: <1334236726-18393-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Thu, 12 Apr 2012 09:18:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FADB7E6-84CD-11E1-B0E2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195353>

Tim Henigan <tim.henigan@gmail.com> writes:

> +sub setup_dir_diff
> +{
> +	# Run the diff; exit immediately if no diff found
> +	my $cmd = "git diff --raw --no-abbrev -z " . join(" ", @ARGV);
> +	my $diffrtn = `$cmd` or die $!;

Why this change?  It looks like a rather unpleasant regression compared to
the previous one that used "command_oneline", so that each element of
@ARGV was given as a single argument to the command.  Now, you are
splitting any argument that has $IFS in it.
