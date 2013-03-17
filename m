From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: support exclusively locked files
Date: Sun, 17 Mar 2013 16:04:37 -0400
Message-ID: <20130317200437.GA29115@padd.com>
References: <CD666D0F.1DC6E%danny.thomas@blackboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Danny Thomas <Danny.Thomas@blackboard.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 21:02:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHJmw-0006nm-4W
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 21:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756544Ab3CQUCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 16:02:12 -0400
Received: from honk.padd.com ([74.3.171.149]:46252 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756411Ab3CQUCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 16:02:09 -0400
Received: from tic.padd.com (unknown [216.115.121.27])
	by honk.padd.com (Postfix) with ESMTPSA id B225F2C15;
	Sun, 17 Mar 2013 13:02:08 -0700 (PDT)
Received: by tic.padd.com (Postfix, from userid 1000)
	id 923CB1015FF; Sun, 17 Mar 2013 16:04:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CD666D0F.1DC6E%danny.thomas@blackboard.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218370>

Danny.Thomas@blackboard.com wrote on Wed, 13 Mar 2013 13:51 -0400:
> By default, newly added binary files are exclusively locked by Perforce:
> 
> 'add default change (binary+l) *exclusive*'
> 
> This results in a 'Could not determine file type' error as the regex
> expects
> the line to end after the file type matching group. Some repositories are
> also configured to always require exclusive locks, so may be a problem for
> all revisions in some cases.

Can you explain how to configure p4d to default everything to
binary+l?  Also, what version are you using ("p4 info")?  I'm
trying to write a test case for this.

I did find a way to play with typemap to get +l, as:

    ( p4 typemap -o ; printf "\tbinary+l\t//.../bash*" ) | p4 typemap -i

With this, the 2011.1 here just says:

    tic-git-test$ p4 opened bash
    //depot/bash#1 - add default change (binary+l)

I've not been able to make it say " *exclusive*" too.

>      result = p4_read_pipe(["opened", wildcard_encode(file)])
> -    match = re.match(".*\((.+)\)\r?$", result)
> +    match = re.match(".*\((.+)\)(?:.+)?\r?$", result)

I think this whole function would be less brittle
using p4's "-G" output, like:

    d = p4Cmd(["fstat", "-T", "type", wildcard_encode(file)])
    # some error checking
    return d['type']

But I'm curious if your p4d includes " *exclusive*" in the
type there too, in which case we'll have to strip it.

Thanks for starting the patch on this.  It's good if we can keep
others from running into the same problem.

		-- Pete
