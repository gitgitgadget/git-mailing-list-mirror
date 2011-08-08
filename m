From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support specific color for a specific remote branches
Date: Mon, 08 Aug 2011 11:08:26 -0700
Message-ID: <7v8vr3zsh1.fsf@alter.siamese.dyndns.org>
References: <1312818553-25042-1-git-send-email-avivey@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aviv Eyal <avivey@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 20:08:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqUFe-0006Jg-T8
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 20:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088Ab1HHSIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 14:08:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39028 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603Ab1HHSI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 14:08:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFE3B4C02;
	Mon,  8 Aug 2011 14:08:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aXjKoTiPS880PstL6hawcCRsk3Y=; b=E74TE8
	UGf3ZSEZqwOR8yPttqF5cVWf2vFLp4PlncWkjxV/7sT2MkRODBZ/uzfdmtTNI9PC
	Ta5F6rvbl/fRi61ZPIcu9cgwlaOEG3RbweQvAGIKcEFIhigFxnzME2PWeJracePy
	IFD40Xjhcbx71PUake6T8PSHZRumAInTWwRsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CEBz2pngs3T5v2aYd3IrF9FvjPKEeg5U
	J1x7gjGLJKUoNAaWzcwjgXFSbGUVLcL7O1+CF93oy4r8a0oTXDxLDui9jtoDlUc0
	JLCLdsC+bhjeIh58vEfWNJ2/vJx7i8t3GvqfpjLP/9uZBfoaarjMtULa9ifHfATb
	MziU57zukwc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7B5E4C01;
	Mon,  8 Aug 2011 14:08:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D4A14C00; Mon,  8 Aug 2011
 14:08:28 -0400 (EDT)
In-Reply-To: <1312818553-25042-1-git-send-email-avivey@gmail.com> (Aviv
 Eyal's message of "Mon, 8 Aug 2011 18:49:13 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AA67870-C1E9-11E0-9F22-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178968>

Aviv Eyal <avivey@gmail.com> writes:

> +remote.<name>.color:
> +	If set, the `branch` command will use the colors specified here
> +	for the names of all branches tracking this remote. Colors
> +	specified here take precedent over `color.branch.remote` config.

> +static char *strclone(const char *start, int len)
> +{

Hmm, don't we have xmemdupz() for this?

> +	char *result = malloc((len + 1) * sizeof(char));
> +	if (!result)
> +		return NULL;
> +	strncpy(result, start, len);
> +	result[len] = '\0';
> +	return result;
> +}
> +
> +static int git_branch_config_custom_color_remote(const char *var, const char *value)
> +{
> +	struct string_list_item *item;
> +	char *name, *color;
> +	name = strclone(var + 7, strlen(var) - 13); // "remote."=7, "remote..color"=13.

No // comments please.

> +	if (!name)
> +		return 0;
> +	color =  malloc(COLOR_MAXLEN * sizeof(char));

At least use xmalloc(); also isn't sizeof(char) by definition 1?

> +	if (!color) {
> +		free(name);
> +		return 0;
> +	}
> +	item = string_list_insert(&custom_colors, name);
> +	color_parse(value, var, color);
> +	item->util = color;

It may be just a style thing, but I'd rather see this caller call
color_parse() first, and after letting that function validate the end-user
input, call string_list_insert().

Also what happens when there are two entries that talk about the same
remote branch in the configuration? Such a configuration is not an error;
your ~/.gitconfig may say one thing for remote.origin.master and your
repository specific .git/config may override it for a particular
repository.

> +	return 0;
> +}
> +
> +static char *git_branch_get_custom_color_remote(const char *name)
> +{
> +	int name_len;
> +	char* repo_name;
> +	struct string_list_item *custom;
> +	name_len = strchr(name, '/') - name;

Who said a remote name is terminated with (and cannot contain) a slash?

Shouldn't this code be consulting the configuration file to learn the
remote mapping, e.g.

    [remote "frotz"]
        fetch = +refs/heads/*:refs/remotes/nitfol/*

so that remote branches from "frotz" remote, that happen to be stored
under refs/remotes/nitfol/ hierarchy, are painted in the correct color?
