From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin-merge: add support for default merge options
Date: Fri, 06 Mar 2009 14:46:09 -0800
Message-ID: <7vr61aqngu.fsf@gitster.siamese.dyndns.org>
References: <cover.1236377358.git.jaysoffian@gmail.com>
 <12addb53ef5c0e62ee22847591c8e7b884dc0bd2.1236377358.git.jaysoffian@gmail.com> <13f0016028b195541b8b5d9149292150cbb13ab7.1236377358.git.jaysoffian@gmail.com> <9f755b5bae0b02c5cb3e01680acf71fe7153be04.1236377358.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jean-luc malet <jeanluc.malet@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 23:47:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfipY-0000VT-18
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 23:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631AbZCFWqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 17:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbZCFWqT
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 17:46:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59838 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbZCFWqT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 17:46:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DFDAF2E85;
	Fri,  6 Mar 2009 17:46:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 05E9B2E82; Fri, 
 6 Mar 2009 17:46:10 -0500 (EST)
In-Reply-To: <9f755b5bae0b02c5cb3e01680acf71fe7153be04.1236377358.git.jaysoffian@gmail.com> (Jay Soffian's message of "Fri, 6 Mar 2009 17:15:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9A65625E-0AA0-11DE-ACA5-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112489>

Jay Soffian <jaysoffian@gmail.com> writes:

> @@ -838,6 +847,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  	if (is_null_sha1(head))
>  		head_invalid = 1;
>  
> +	git_config(git_merge_config_default, NULL);
>  	git_config(git_merge_config, NULL);


The placement of this comes before parse_options(), just like the part
that slurps "branch.*.mergeoptions", so it can be overridden by the
command line just like "branch.*.mergeoptions" can, which is good.

When you are on branch "frotz", your config have both merge.options and
branch.frotz.mergeoptions, and you give some other options from the
command line, how should they interact?  I'd expect the branch.*.options
to take effect, ignoring merge.options entirely.

I think the right way to structure this is to change the code in
git_merge_config() that accepts "branch.*.mergeoptions" to just store a
xstrdup() pointer away, add a similar thing in the same function for the
new "merge.options" variable.  Get rid of your git_merge_config_default
function that forces git_config() to iterate over the same config file one
more time.  And after the config parser returns, run the parse_options
only once.

In other words, the overall code structure would look like this:

static char *options_from_config;
static int options_from_config_taken_from_branch_config;

static int git_merge_config(...)
{
	if (branch && !prefixcmp(k, "branch.") ... ) {
		/*
                 * We may have found merge.options first;
		 * free it and override it with the value of
                 * branch.*.mergeoptions for the current branch
                 * we just found.
                 */
        	free(options_from_config);
               	options_from_config_taken_from_branch_config = 1;
               	options_from_config = xstrdup(value);
		return 0;
	}
        if (!strcmp(k, "merge.options")) {
		/*
                 * Do not override branch.*.mergeoptions for the
                 * current branch if we already found one.
                 */
               	if (!options_from_config_taken_from_branch_config)
                	options_from_config = xstrdup(value);
		return 0;
	}
        ...
}

int cmd_merge(...)
{
	...
        git_config(git_merge_config, NULL);
        if (options_from_config)
		/*
                 * There is a "prime" options given in
                 * the configuration file.  Parse it.
                 */
                git_config_option_string(builtin_merge_options, ...,
                			options_from_config);
	...
        argc = parse_options(argc, argv, builtin_merge_options,...);
	...
}

If for some reason you would want to have cumulative options across
branch.*.merge, merge.options and the command line, then you would instead
keep two separate strings, and call git_config_option_string() for both of
them, before processing the real command line options.

Hmm?
