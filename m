From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bug encountered while comitting
Date: Fri, 24 Mar 2006 22:17:09 -0800
Message-ID: <7vwtejxd3u.fsf@assigned-by-dhcp.cox.net>
References: <20060324183951.GA23193@spinlock.ch>
	<7vacbfzc3u.fsf@assigned-by-dhcp.cox.net>
	<20060325011527.GA23600@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 25 07:17:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN25L-0007ud-IY
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 07:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWCYGRN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 01:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWCYGRN
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 01:17:13 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:60647 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751079AbWCYGRM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 01:17:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060325061711.QWQZ3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 01:17:11 -0500
To: Matthias Kestenholz <lists@irregular.ch>
In-Reply-To: <20060325011527.GA23600@spinlock.ch> (Matthias Kestenholz's
	message of "Sat, 25 Mar 2006 02:15:27 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17956>

Matthias Kestenholz <lists@irregular.ch> writes:

> $ sudo chown root .git/objects/*
>
> repeat the modification and commit commands until you get a message
> similar to the following:
>
> unable to write sha1 filename .git/objects/90/b33..: Permission denied
> fatal: 90b33... is not a valid 'tree' object
> unable to write sha1 filename .git/objects/ba/fe4..: Permission denied
> error: file: failed to insert into database
> fatal: Unable to process file file
> etc...
>
> The result of this all is: refs/heads/master might now point to a
> non-existant commit object. Every git command now errors out with:
>
> fatal: bad tree object HEAD
>
> and git-log shows no output (probably since it does not find a
> commit to begin with)

You are right.  commit-tree does not seem to check if it
successfully wrote the commit object.  How about this?

-- >8 --
diff --git a/commit-tree.c b/commit-tree.c
index 88871b0..16c1787 100644
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -125,7 +125,10 @@ int main(int argc, char **argv)
 	while (fgets(comment, sizeof(comment), stdin) != NULL)
 		add_buffer(&buffer, &size, "%s", comment);
 
-	write_sha1_file(buffer, size, "commit", commit_sha1);
-	printf("%s\n", sha1_to_hex(commit_sha1));
-	return 0;
+	if (!write_sha1_file(buffer, size, "commit", commit_sha1)) {
+		printf("%s\n", sha1_to_hex(commit_sha1));
+		return 0;
+	}
+	else
+		return 1;
 }
