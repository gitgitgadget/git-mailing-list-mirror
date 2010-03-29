From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] Add git alternate command
Date: Mon, 29 Mar 2010 00:32:29 -0700
Message-ID: <7vr5n37fci.fsf@alter.siamese.dyndns.org>
References: <a038bef51003241335l1623ade4i4a9b7269546739d4@mail.gmail.com>
 <1269497251-13103-2-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
	bebarino@gmail.com
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 09:33:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw9Sz-0005cI-0U
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 09:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab0C2Hcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 03:32:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384Ab0C2Hcv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 03:32:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C998CA6EFE;
	Mon, 29 Mar 2010 03:32:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=iSYHZATQP4BmLoCAVyOQjvSllXo=; b=vzJi3CFTBn04oejYZQFwFek
	3awfLotWOhp7cix55BYW7xkST/+yRdZZbatI0JMeRSQaTLDE4MhcfPsLPN+v0EPR
	gpf03ds5n/RvV7FiCozmE4VJeGt57Yd2VqBEgcO+tuDHlWr92fM+SilL5+128ewc
	jJJwDAQyOCCZw7LkpQrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=XHCWBaaTedTzKb/s0jy9F/r4zMnRLfbvTo1kt5DZVvjGCoL2I
	H+1Er6hjPwDzGCx7BzZ27YEfSdNZFG4hbmr1YIeK2Oajr8aBluipCBJc6ppNfqV4
	+ejc7VuQiIJpHK+SWqjfW2hfkTfzjBaHI26RrInz/KDqaDSpf7tLGn3Gvw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D874A6EFB;
	Mon, 29 Mar 2010 03:32:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13BA8A6EE6; Mon, 29 Mar
 2010 03:32:32 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 445249E0-3B05-11DF-BC34-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143447>

Chris Packham <judge.packham@gmail.com> writes:

> +abspath()
> +{
> +	cd "$1"
> +	pwd
> +	cd - > /dev/null
> +}

I do not think "cd -" is all that portable.  As you will be always using this in
this form:

	somevariable=$(abspath "$it")

you are in a subshell and won't affect the caller anyway.  Why not drop
the "go back to where we came from"?

Also a shell built-in "pwd" tends to be fooled by $PWD especially since
you are running "cd" without -P.

> +#
> +# Runs through the alternates file calling the callback function $1
> +# with the name of the alternate as the first argument to the callback
> +# any additional arguments are passed to the callback function.
> +#
> +walk_alternates()

This is more like "for_each_alternates"; "walk" can be mistaken as if you
are recursively looking at alternates defined in alternate repositories
of the repository you start from.

> +{
> +	alternates=$GIT_DIR/objects/info/alternates
> +	callback=$1
> +	shift
> +
> +	if test -f "$alternates"
> +	then
> +		while read line
> +		do
> +			$callback "$line" "$@"
> +		done< "$alternates"

	done <"$alternates"

How well does this handle relative alternate object stores?  Shouldn't it
be more like this?

	while read altdir
        do
        	case "$altdir" in
                /*) ;; # full path
                *) altdir="$GIT_DIR/objects/$altdir" ;;
                esac &&
                $callback "$altdir" "$@"
	done <"$alternates"

> +# Walk function to display one alternate object store and, if the user
> +# has specified -r, recursively call show_alternates on the git 
> +# repository that the object store belongs to.
> +#
> +show_alternates_walk()
> +{
> +	say "Object store $1"
> +	say "    referenced via $GIT_DIR"
> +
> +	new_git_dir=${line%%/objects}

Do you need double-% here, not a single one?

> +# Add a new alternate
> +add_alternate()
> +{
> +	if test ! -d "$dir"; then
> +		die "fatal: $dir is not a directory"
> +	fi
> +
> +	abs_dir=$(abspath "$dir")
> +	walk_alternates check_current_alternate_walk "$abs_dir"
> +
> +	# At this point we know that $dir is a directory that exists
> +	# and that its not already being used as an alternate. We could

s/its/(it's|it is)/;

But I don't think it is true that you have verified that it is not used.
You are running abspath on the input from the end user, but you are using
existing entries in the alternates file that may not be absolute.  They
can be relative to $GIT_DIR/objects/.

> +	say "    use 'git repack -adl' to remove duplicate objects"

Good.

> +# Deletes the name alternate from the alternates file.
> +# If there are no more alternates the alternates file will be removed
> +del_alternate()
> +{
> +	if test ! $force = "true"; then
> +		say "Not forced, use"
> +		say "    'git repack -a' to fetch missing objects, then "
> +		say "    '$dashless -f -d $dir' to remove the alternate"
> +		die

Hmm, I am afraid that this will end up training users to always say -f
without even thinking.  Shouldn't this code be doing whatever necessary
steps to make sure this repository has all the necessary objects without
the named alternates and then removing the file?  An easiest might be to
temporarily remove the entry and run fsck, perhaps?
