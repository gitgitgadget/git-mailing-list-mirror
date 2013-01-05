From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] list_lookup: create case and length search
Date: Sat, 05 Jan 2013 14:39:18 -0800
Message-ID: <7vmwwnp84p.fsf@alter.siamese.dyndns.org>
References: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
 <1357421206-5014-2-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 23:41:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrcQk-000327-Hn
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 23:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899Ab3AEWjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 17:39:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34361 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755865Ab3AEWjV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 17:39:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBAF9A83B;
	Sat,  5 Jan 2013 17:39:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2nz/TAcg1w5u8ECPM0TRij9tgfY=; b=klLL6H
	7mrXkiDpsXy29COFf472IikK+1tO5UzQzJvV4tD2MoNQ/h2t572GxG3mjaCtSDKI
	R8CBOZrCFLqFrROStumPJaDhO6c7YIQlGC4XpGDCgB7CoypvCCLLffjsnfOkJ6bP
	BjRuMXCDgGdfxkr7iZxbCq9yr34+bVs3VNigo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ToTNacdGDBVwvO5DS0TuwDj86JwEZoAk
	76a8npUZPwo9CvaevCys90cp2bo/UTQKx0D2PwjGLoXthkDEKyYMSeHc7jJ3sqGm
	MeO4z/EFOXNmxUZrvFFrdKbB0NVdLhHCLO2rRSW2vHx/m09F0Djgxf7hvqDGfwxn
	JjuEmSULyrE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD6C6A83A;
	Sat,  5 Jan 2013 17:39:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30A66A838; Sat,  5 Jan 2013
 17:39:20 -0500 (EST)
In-Reply-To: <1357421206-5014-2-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Sat, 5 Jan 2013 22:26:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BEC1ACB4-5788-11E2-900A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212731>

Antoine Pelisse <apelisse@gmail.com> writes:

> Create a new function to look-up a string in a string_list, but:
>  - add a new parameter to ignore case differences
>  - add a length parameter to search for a substring
>
> The idea is to avoid several copies (lowering a string before searching
> it when we just want to ignore case), or copying a substring of a bigger
> string to search it in the string_list
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---

I did not read beyond the log message and the function signature of
the updated get_entry_index(), but it strikes me insane to build a
sorted list using case sensitive full string comarison and then to
look for an element in that list using a different comparison
criteria (e.g. case insensitive comparison) and to expect the
bisection search to still work.  Shouldn't the codepath that builds
the string-list be sorting the list in case insensitive way from the
beginning if this were to work correctly?

It seems to suggest to me that this "are the keys case sensitive?"
bit belongs to the entire struct string_list structure as its
property (similar to the way "do the keys need to be strdup'ed?"
bit), not something you would flip per invocation basis of the
lookup function.

Also isn't size_t an unsigned type?  What does it even mean to pass
"-1" to it, and propagate it down to strncmp()?

If you have a list sorted by a key, and if you want to query it with
a partial prefix of a possibly valid key, I think you shouldn't have
to add the "length search" at all. The existing look up function
would return the location in the list that short key would have been
inserted, which would come before the first entry that your short
key is a prefix of, so the caller can iterate the list from there to
find all entries.  In other words, if existing list has "aaa",
"bba", and "bbc", and you want to grab entries that begin with "bb",
you can ask for "bb" to the loop up function, which would say "the
key does not exist in the list, but it would be inserted before this
'bba' entry".  Then you can discover that "bba" and "bbc" both
matches the shortened key you have, no?
