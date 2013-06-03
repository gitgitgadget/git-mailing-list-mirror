From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] t/send-email.sh: add test for suppress-cc=self
Date: Mon, 03 Jun 2013 09:19:49 -0700
Message-ID: <7vk3mbi2u2.fsf@alter.siamese.dyndns.org>
References: <1369897638-27299-1-git-send-email-mst@redhat.com>
	<1369897638-27299-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 18:19:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjXUD-0007sY-1j
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 18:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759288Ab3FCQTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 12:19:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38795 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758924Ab3FCQTw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 12:19:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE76924303;
	Mon,  3 Jun 2013 16:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=nMZsMr9p3vqHTYIq0Jd+QMiAbYo=; b=hngLM8M8T2VjCnX+hNns
	CwzJ5asRB5c8sSYDSTyKgiDntdQ1/tV30STbzz6eWkNNK5Hn6IvjSHO7Uz+OKRQo
	kj4ECJkN+iT1QdCyNYzJKGq6EaENPVvXlroiz1PMZXtkzpitHiwVjzv8MFkpeflp
	ZtuwptfmRqIYUjAPPcyXEW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=j/Pb0OcERK1k+3JVcnzIMh4ZPjO+06zHW6sKwqmuAyC5tS
	WPLMuhnRN/EwqrDVaSg08tc8p8xjaIw4tYR47oR4+x18jBYUr5frD2gv98f8+ikp
	Qt17OA/3cjDHqaWTHhq4yg9ZYM6bSAWFKo5uWn2nvrwX+3wxqEidHBKNRdfwk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAABB24302;
	Mon,  3 Jun 2013 16:19:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27EC9242FF;
	Mon,  3 Jun 2013 16:19:51 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AE7983C-CC69-11E2-BC4A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226231>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> This adds a basic test for --suppress-cc=self
> option of git send-email.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  t/t9001-send-email.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index ebd5c5d..e1a7f3e 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -171,6 +171,49 @@ Result: OK
>  EOF
>  "
>  
> +test_suppress_self () {
> +	test_commit $3 &&
> +	test_when_finished "git reset --hard HEAD^" &&
> +
> +	write_script cccmd-sed <<-EOF &&
> +		sed -n -e s/^cccmd--//p "\$1"
> +	EOF
> +
> +	git commit --amend --author="$1 <$2>" -F - &&  

Ahh, this helper reads the log message from its standard input;
nice.

> +	clean_fake_sendmail &&  
> +	git format-patch --stdout -1 >"suppress-self-$3.patch" &&  
> +
> +	git send-email --from="$1 <$2>" \
> +		--to=nobody@example.com \
> +		--cc-cmd=./cccmd-sed \
> +		--suppress-cc=self \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		suppress-self-$3.patch &&
> +
> +	mv msgtxt1 msgtxt1-$3 &&
> +	sed -e '/^$/q' msgtxt1-$3 >"msghdr1-$3" &&
> +	>"expected-no-cc-$3" &&
> +
> +	(grep '^Cc:' msghdr1-$3 >"actual-no-cc-$3";
> +	 test_cmp expected-no-cc-$3 actual-no-cc-$3)
> +}
> +
> +test_suppress_self_unquoted () {
> +	test_suppress_self "$1" "$2" "unquoted-$3" <<-EOF
> +		test suppress-cc.self unquoted-$3 with name $1 email $2
> +
> +		unquoted-$3
> +
> +		Cc: $1 <$2>
> +		Signed-off-by: $1 <$2>
> +	EOF
> +}
> +
> +test_expect_success $PREREQ 'self name is suppressed' "
> +	test_suppress_self_unquoted 'A U Thor' 'author@redhat.com' \
> +		'self_name_suppressed'
> +"
> +
>  test_expect_success $PREREQ 'Show all headers' '
>  	git send-email \
>  		--dry-run \
