From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Introduce git-run-with-user-path helper program.
Date: Tue, 17 May 2005 12:27:03 -0700
Message-ID: <7vk6lxfybc.fsf@assigned-by-dhcp.cox.net>
References: <7voebbpuxs.fsf@assigned-by-dhcp.cox.net>
	<20050517190355.GA7136@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue May 17 21:30:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY7jB-0000BW-J6
	for gcvg-git@gmane.org; Tue, 17 May 2005 21:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVEQT1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 15:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVEQT1d
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 15:27:33 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:42465 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261347AbVEQT1F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2005 15:27:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050517192704.KPKD7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 May 2005 15:27:04 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050517190355.GA7136@pasky.ji.cz> (Petr Baudis's message of
 "Tue, 17 May 2005 21:03:55 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

>> +int path_ignored(const char *path)
>> +{
>> +	if (!verify_path(path))
>> +		return 1;
>> +
>> +	/* Put the Porcelain layer ignore logic here.
>> +	 * Return non-zero if path is to be ignored.
>> +	 */
>> +	return 0;
>> +}

PB> I actually think you shouldn't. All the Porcelain layers should
PB> hopefully use the same git toolkit layer, not each one shipping own due
PB> to differences in things like this.

What you said above _is_ exactly my intention.  I phrased that
comment very badly.  It should have said:

    /* We _will_ put the "ignore logic Porcelain layers agree upon"
     * here, once we have a concensus.
     *
     * The code should return non-zero if path is to be ignored.
     */

I did not put any implementation there because I do not think we
have agreed upon anything yet.  This patch is to establish
the framework.  

The second patch is separate, because it is _my_ version of the
ignore logic proposal, to serve as a sample.  Whatever ignore
logic is agreed upon, that _will_ be in the place you pointed
out and there will be no choice.  Everybody _will_ use the
ignore logic.

>> +/****************************************************************/
>> +
>> +/* Path canonicalization part */

PB> And why is this in the library?

Why not?  It is something other programs would eventually find
useful.

Also the second patch, a sample implementation of ignore logic I
proposed, wants to know GIT_PROJECT_TOP to figure out the file
pointed at by GIT_DIR/.git/info/ignore-file.

Also it would not hurt if you are always running from the
project top and give only verify_path() approved paths.  Then
canon_path would become identity function.

git-run-with-user-path is useful both in implementing
porcelain-add if the porcelain's policy is to take filesystem
paths not GIT paths, like this:

    #!/bin/sh
    # porcelain-add
    exec git-run-with-user-path git-update-cache --add -- -- "$@"

Also if the porcelain's policy is to take GIT paths not
filesystem paths, then users can say:

    $ find . ! -type d -print0 |
      xargs -0 git-run-with-user-path cg-add --

You cannot use both for obvious reasons.

