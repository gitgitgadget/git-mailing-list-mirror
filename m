From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] rename/rename conflicts: do they matter?
Date: Wed, 08 Jun 2005 17:34:15 -0700
Message-ID: <7v4qc81i7s.fsf@assigned-by-dhcp.cox.net>
References: <7vll5k69y0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 02:33:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgAyQ-0003DC-EE
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 02:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVFIAgB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 20:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVFIAfN
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 20:35:13 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:5822 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262222AbVFIAeR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2005 20:34:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609003416.UHJB1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Jun 2005 20:34:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vll5k69y0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 08 Jun 2005 10:21:43 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> I was reviewing git-merge-one-file-script, and started
JCH> thinking...

But somehow I got underwhelming responses.

I further think the "WARNING: " below is needlessly eating one
extra line of screen real estate without any additional value.

If one tree renamed a file (and creating the same or similar
file in another location) while the other tree kept the file
intact, then we would see "Removing $4" from the "deleted in one
and unchanged in the other" (and corresponding "Adding $4 with
perm $mode" for the rename destination).  If the user wants to
be careful about renames then all "Removing ..." need to be
examined _anyway_.  I would think it would be saner to collapse
these two case arms to catch "$1.." | "$1.$1" | "$1$1."  pattern
and just say "Removing $4".

    case "${1:-.}${2:-.}${3:-.}" in
    #
    # Deleted in both.
    #
    "$1..")
            echo "WARNING: $4 is removed in both branches."
            echo "WARNING: This is a potential rename conflict."
            rm -f -- "$4" &&
                    exec git-update-cache --remove -- "$4"
            ;;

    #
    # Deleted in one and unchanged in the other.
    #
    "$1.$1" | "$1$1.")
            echo "Removing $4"
            exec rm -f -- "$4" &&
                    git-update-cache --remove -- "$4"
            ;;


