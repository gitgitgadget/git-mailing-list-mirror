From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/12] attr: convert git_all_attrs() to use "struct git_attr_check"
Date: Tue, 17 May 2016 10:00:52 -0700
Message-ID: <xmqqeg90y5yz.fsf@gitster.mtv.corp.google.com>
References: <20160516210545.6591-1-gitster@pobox.com>
	<20160516210545.6591-11-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 19:01:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2iMe-0007j2-Fl
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 19:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbcEQRA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 13:00:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750941AbcEQRA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 13:00:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EFB0719C1D;
	Tue, 17 May 2016 13:00:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GuSn04x+b5dLpOFgd5TLBYj9fD8=; b=hY/e9A
	F9wIgi1htkYGtqo5VVKF5XQXsY4G0Mn9QasViKqAL25FDZzVGiAZDNL5Ten7bqc9
	WoiJEB4c8Ye/soS5mFwdDPZsffHpirJD/6NMTQsCrhHCP2za/2F7aCgFZwuyJXQk
	ajpTouTspxNaTDrOTtnadCsyaPUiup0y9hHwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lYyuU+GmO5wrwve46UxxSTBYPnoRqjnw
	UULDYct/4DYMPUNC61fFdBM0G9GCv+ehDBnHBcNFqf23EwI7tNuq+VsVuZvEtQoD
	03g92klSMI5vS3rNia3d16+823cZDhTWMIfd3d0dVuEnin/9/a505xCxdfD+nt9A
	FREZhc/CLGo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E491519C1C;
	Tue, 17 May 2016 13:00:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 518F519C1A;
	Tue, 17 May 2016 13:00:54 -0400 (EDT)
In-Reply-To: <20160516210545.6591-11-gitster@pobox.com> (Junio C. Hamano's
	message of "Mon, 16 May 2016 14:05:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EACA49C0-1C50-11E6-AE27-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294876>

Junio C Hamano <gitster@pobox.com> writes:

> +struct git_attr_check *git_attr_check_alloc(void)
> +{
> +	return xcalloc(1, sizeof(struct git_attr_check));
> +}
> +
> +void git_attr_check_append(struct git_attr_check *check, const char *name)
> +{
> +	struct git_attr *attr;
> +
> +	if (check->finalized)
> +		die("BUG: append after git_attr_check structure is finalized");
> +
> +	attr = git_attr(name);
> +	if (!attr)
> +		die("%s: not a valid attribute name", name);
> +	ALLOC_GROW(check->check, check->check_nr + 1, check->check_alloc);
> +	check->check[check->check_nr++].attr = attr;
> +}

Given that one of the two expected callers, namely, "check-attr" and
Stefan's pathspec label magic, of this "alloc and then append" side
of the API wants to have an access to git_attr(name), I think
the function signature for this one should be updated to take not
"const char *name" but instead take "struct git_attr *attr", i.e.

void git_attr_check_append(struct git_attr_check *check,
			   struct git_attr *attr);

Then the loop in check-attr below

> +		check = git_attr_check_alloc();
> +		for (i = 0; i < cnt; i++)
> +			git_attr_check_append(check, argv[i]);

would become

		check = git_attr_check_alloc();
		for (i = 0; i < cnt; i++)
			git_attr_check_append(check, git_attr(argv[i]));

And this part in $gmane/294855

    Then while parsing ":(attr:VAR1=VAL1 -VAR2 VAR3...)path/to/dir/",
    you would first do:

            p->attr_check = git_attr_check_alloc();

    once, and then send each of VAR1=VAL2, -VAR2, VAR3... to your
    parse_one_item() helper function which would:

     * parse the match-mode like your code does;

     * parse out the attribute name (i.e. VAR1, VAR2 and VAR3), and
       instead of keeping it as a "(const) char *", call git_attr()
       to intern it (and keep it in local variable "attr"), and save
       it in p->attr_match[p->attr_nr].attr;

     * call git_attr_check_append(p->attr_check, git_attr_name(attr))

would look like

	... saw ":(attr:", expect "VAR1=VAL1 -VAR2...)" to follow;
        ... char *scan points at byte after attr: now.

	item->attr_check = git_attr_check_alloc();
	while (scan) {
		const char *var, *val;
                enum attr_match_mode mode;
		struct git_attr *attr;
		struct attr_match *match;

        	scan = parse_attr_match(scan, &var, &val, &mode);
                ... var points at VAR1, val points at VAL,
                ... mode becomes MATCH_VALUE; scan skips
                ... forward to pint at -VAR2.  parse_attr_match()
                ... would return NULL once input runs out.

                ALLOC_GROW(item->attr_match, ...);
                match = &item->attr_match[item->attr_match_nr++];

        	attr = git_attr(var);

		match->attr = attr;
                match->value = val;
                match->match_mode = mode;
                
                git_attr_check_append(item->attr_check, attr);
	}

Then matching part would get the "item" and would do:

	... after making sure that the path matches
        ... the pathspec the magic is attached to ...

	git_check_attr(path, item->attr_check);
	for (i = 0; i < item->attr_match_nr; i++) {
		struct git_attr *attr = item->attr_check->check[i].attr;
		const char *value = item->attr_check->check[i].value;
                struct attr_match *match = &item->attr_match[i];

                ... compare what "match" expects with <attr, value> ...
        }
