From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] fast-import: tighten parsing of datarefs
Date: Tue, 10 Apr 2012 14:40:49 -0700
Message-ID: <7vzkajnu3i.fsf@alter.siamese.dyndns.org>
References: <20120401225407.GA12127@padd.com>
 <1333417910-17955-1-git-send-email-pw@padd.com>
 <20120405015121.GA10945@padd.com> <20120407225920.GA3948@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 23:40:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHio6-0003mt-A6
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 23:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759514Ab2DJVkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 17:40:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41862 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759354Ab2DJVkw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 17:40:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24E827E2A;
	Tue, 10 Apr 2012 17:40:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GJpNZX1Zr9Q2CknGtawgROVpxd8=; b=r5QTF6
	2qVtB3VB4KWcdXs+uZ/yztk16anZuEuQjOrtXFKAToHXI5KQ+sN1fHoROfpYecCE
	NdF97dQ4hN4FK9tY9rBQHoAHAM1swdsausTRREOG7Klv9PsJfVrIJkmL1sUBHszJ
	xhWMlTiYMUVwR/gKQ7xopE3eNoYwy/p0tpjKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vTlzsg+rzuuIsJYkaAyGnDKg7Or8n+VW
	oqkCKI/NNDk6hhwfMNZjaR4/ZqVRzL8pTXMc+fyA7j+XDnXqEpFqNZOz60R0DlHj
	7tV/6HEdORstitHp3Foo/agvNwY9A7WRdH/UmuuuqQkxZnvfWOlc5zfS4lbjhl9o
	JnBB0PRKFVg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1858E7E28;
	Tue, 10 Apr 2012 17:40:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 987967E24; Tue, 10 Apr 2012
 17:40:50 -0400 (EDT)
In-Reply-To: <20120407225920.GA3948@padd.com> (Pete Wyckoff's message of
 "Sat, 7 Apr 2012 18:59:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D76010D8-8355-11E1-AB4B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195132>

Pete Wyckoff <pw@padd.com> writes:

> The syntax for the use of mark references in fast-import
> demands either a SP (space) or LF (end-of-line) after
> a mark reference.  Fast-import does not complain when garbage
> appears after a mark reference in some cases.
> 
> Factor out parsing of mark references and complain if
> errant characters are found.  Also be a little more careful
> when parsing "inline" and SHA1s, complaining if extra
> characters appear or if the form of the dataref is unrecognized.


> +static uintmax_t parse_mark_ref(const char *p, char **endptr)
> +{
> +	uintmax_t mark;
> +
> +	assert(*p == ':');
> +	++p;
> +	mark = strtoumax(p, endptr, 10);
> +	if (*endptr == p)
> +		die("No value after ':' in mark: %s", command_buf.buf);
> +	return mark;
> +}

> +static uintmax_t parse_mark_ref_eol(const char *p)
> +{
> +...
> +}
> +
> +static uintmax_t parse_mark_ref_space(const char **p)
> +{
> +...
> +}
> +

The first helper looks sensible, but the two seemingly similar
parse_mark_ref_WHATTOEXPECT() that have different interfaces are somewhat
tasteless.

I wonder if the calling sites in file_change_m(), note_change_n(),
parse_merge(), parse_cat_blob() and parse_treeish_dataref() can be made to
share even more code by slight restructuring, though.
