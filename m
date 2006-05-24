From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add a test-case for git-apply trying to add an ending line
Date: Tue, 23 May 2006 17:31:33 -0700
Message-ID: <7vd5e4z2je.fsf@assigned-by-dhcp.cox.net>
References: <20060523214836.22628.2179.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 02:31:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FihHp-0004Fn-T9
	for gcvg-git@gmane.org; Wed, 24 May 2006 02:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWEXAbf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 20:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWEXAbf
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 20:31:35 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:57036 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932275AbWEXAbf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 20:31:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060524003134.KYVO5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 May 2006 20:31:34 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060523214836.22628.2179.stgit@localhost.localdomain> (Catalin
	Marinas's message of "Tue, 23 May 2006 22:48:36 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20652>

Hmmmmm.

To git-apply, this patch:

        diff --git a/file b/file
        --- a/file
        +++ b/file
        @@ -1,2 +1,3 @@
         a
         b
        +c

currently means "I want to append a line c immediately after the
lines that have a and then b".  Nothing else.  And applying it
to

	a
        b
        c

produces

	a
        b
        c
        c

The first c is what your patch added, and the second c is what
was originally there.

I do not think this is necessarily a bug.  You _could_ make the
EOF a special case (i.e. you _could_ interpret the patch that it
also says, with "@@ -1,2", that "the result of this patch _must_
end with this line I just added"), and if you are going to do
that, you would also need a symmetric special case for the
beginning of the file, but I do not think it is the right thing
to do in general.

Realistically, you would have something like this:

        diff --git a/apply.c b/apply.c
        index 0ed9d13..f99c6fe 100644
        --- a/apply.c
        +++ b/apply.c
        @@ -2297,3 +2297,8 @@ int main(int argc, char **argv)

                return 0; /* end of main */
         }
        +
        +static void this_function_is_unused(void)
        +{
        +	printf("hello, world\n");
        +}

You added a useless function at the end of the file.

While you prepared the above patch, the upstream updated the
same file to end like this:

                return 0; /* end of main */
        }

        static int some_new_function(void)
        {
                return 314;
        }

Now, git-apply would produce this file if you apply the above
patch:

                return 0; /* end of main */
        }

        static void this_function_is_unused(void)
        {
                printf("hello, world\n");
        }

        static int some_new_function(void)
        {
                return 314;
        }

I think this current behaviour is more desirable than special
casing the end of file and refusing to apply.

In this particular case, expecting failure like your new test
does is somewhat understandable, but if you change the test case
to start with this file, you would realize that your expectation
is not the only valid understanding of what is really happening:

	echo 'a' >file
	echo 'b' >>file
	echo 'd' >>file

Applying test-patch to this would result in

	a
        b
        c
        d

which I think is more useful behaviour.
