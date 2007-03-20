From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Mon, 19 Mar 2007 22:29:32 -0700
Message-ID: <7vslc0bhz7.fsf@assigned-by-dhcp.cox.net>
References: <1174361424.3143.42.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 06:29:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTWuj-0006nb-Mg
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 06:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933389AbXCTF3d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 01:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933382AbXCTF3d
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 01:29:33 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:34452 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933389AbXCTF3d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 01:29:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070320052934.ORDP28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 20 Mar 2007 01:29:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ctVY1W00P1kojtg0000000; Tue, 20 Mar 2007 01:29:32 -0400
In-Reply-To: <1174361424.3143.42.camel@dv> (Pavel Roskin's message of "Mon, 19
	Mar 2007 23:30:24 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42710>

Pavel Roskin <proski@gnu.org> writes:

> Hello!
>
> I don't know where this problem appeared, but it present in the current
> git (1.5.1-rc1).  Empty files become invalid objects in the repository:
>
> $ touch file 
> $ git-init
> Initialized empty Git repository in .git/
> $ git-add file
> $ git-commit -m "first commit"
> Created initial commit 16a476808d3cb0a4758997ba58193a9dcfad0fd8
> error: garbage at end of loose object
> 'e69de29bb2d1d6434b8b29ae775ad8c2e48c5391'

If the error message above is linewrapped by e-mail, I think it
is coming from here:

    static void *unpack_sha1_rest(z_stream *stream, void *buffer,...
    {
    ...
            if (bytes < size) {
                    stream->next_out = buf + bytes;
                    stream->avail_out = size - bytes;
                    while (status == Z_OK)
                            status = inflate(stream, Z_FINISH);
            }
            buf[size] = 0;
            if ((status == Z_OK || status == Z_STREAM_END) && !stream->avail_in) {
                    inflateEnd(stream);
                    return buf;
            }

            if (status < 0)
                    error("corrupt loose object '%s'", sha1_to_hex(sha1));
            else if (stream->avail_in)
                    error("garbage at end of loose object '%s'",
                          sha1_to_hex(sha1));
            free(buf);
            return NULL;
    }

Can you check what the value of the status is at that point?
