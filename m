From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add--interactive: leave main loop on read error
Date: Mon, 15 Dec 2014 14:49:24 -0800
Message-ID: <xmqqvblcbkaz.fsf@gitster.dls.corp.google.com>
References: <CAN9HoQH5=z-d=J1HCA2UwGuFek21X6qCd_jFEkNpE6GiE50oNg@mail.gmail.com>
	<20141215163527.GA15136@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Benjamin Quorning <bquorning@zendesk.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 15 23:49:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0eSJ-00062G-U0
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 23:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbaLOWt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 17:49:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750949AbaLOWt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 17:49:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DBB4727DDA;
	Mon, 15 Dec 2014 17:49:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aeIMj8laU5Bvhj8cXEVg25Icbok=; b=AdFurC
	rpqWXb9l2QbL4T/xRz72szb6xVs8IDteQiQSbEtTKkkzMHMocAnmU2fwMRFNooZ1
	eYI5zUv4ZEN5wRPVMn9C/CRSqT5vYU5Ior4lOXP6C2xy17rRpITNWASDFzqxZ1Fs
	hioi+kCGeSENvPN+3QFIF4/S8ktb+8dC0cM8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YGv8Drdqcek+6oW3eG9BHNpp8/EISct5
	/ONdhoWewnDTWI56iiel4B0TQh735acvQKkz6LdXVvzYi0eDuN8wjq5VT/EH87s+
	JkfA5BCU+2IR58BCkkK+3xLnEHijApkU+w0JOVbAZz5bdTYfmXR7eBvTntqk1jnn
	0a6c/DvPu/Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1A5927DD9;
	Mon, 15 Dec 2014 17:49:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5911227DD8;
	Mon, 15 Dec 2014 17:49:25 -0500 (EST)
In-Reply-To: <20141215163527.GA15136@peff.net> (Jeff King's message of "Mon,
	15 Dec 2014 11:35:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9E57E24C-84AC-11E4-9300-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261433>

Jeff King <peff@peff.net> writes:

> On Mon, Dec 15, 2014 at 03:41:45PM +0100, Benjamin Quorning wrote:
>
>> Reproduction steps:
>> 
>> 1. A repository with a changed file, but no staged changes.
>> 2. Execute `git checkout --patch`
>> 3. When asked, press `e` to edit a chunk (opens an external editor in my case)
>> 4. With the editor still open, click ctrl-C in the terminal.
>> 5. The diff that was being edited, and the command prompt ("discard
>> this hunk from worktree" etc) is printed to the screen, over and over
>> again.
>> 6. I have to grep and kill this process: /usr/bin/perl
>> /usr/local/Cellar/git/2.2.0/libexec/git-core/git-add--interactive
>> --patch=checkout --
>
> Thanks, I could reproduce this pretty easily with:
>
>   GIT_EDITOR='f() { sleep 60; }; f' git checkout -p
>
> (and then hit 'e', and ^C). Explanation and fix are below.
>
> -- >8 --
> The main hunk loop for add--interactive will loop if it does
> not get a known input. This is a good thing if the user
> typed some invalid input. However, if we have an
> uncorrectable read error, we'll end up looping infinitely.
> We can fix this by noticing read errors (i.e., <STDIN>
> returns undef) and breaking out of the loop.
>
> One easy way to trigger this is if you have an editor that
> does not take over the terminal (e.g., one that spawns a
> window in an existing process and waits), start the editor
> with the hunk-edit command, and hit ^C to send SIGINT. The
> editor process dies due to SIGINT, but the perl
> add--interactive process does not (perl suspends SIGINT for
> the duration of our system() call).
>
> We return to the main loop, but further reads from stdin
> don't work. The SIGINT _also_ killed our parent git process,
> which orphans our process group, meaning that further reads
> from the terminal will always fail. We loop infinitely,
> getting EIO on each read.
>
> Note that there are several other spots where we read from
> stdin, too. However, in each of those cases, we do something
> sane when the read returns undef (breaking out of the loop,
> taking the input as "no", etc). They don't need similar
> treatment.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Thanks.

>  git-add--interactive.perl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 1fadd69..c725674 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1356,6 +1356,7 @@ sub patch_update_file {
>  		  $patch_mode_flavour{TARGET},
>  		  " [y,n,q,a,d,/$other,?]? ";
>  		my $line = prompt_single_character;
> +		last unless defined $line;
>  		if ($line) {
>  			if ($line =~ /^y/i) {
>  				$hunk[$ix]{USE} = 1;
