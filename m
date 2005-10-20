From: Junio C Hamano <junkio@cox.net>
Subject: Re: Revamping the git protocol
Date: Wed, 19 Oct 2005 23:11:17 -0700
Message-ID: <7vwtk8pvju.fsf@assigned-by-dhcp.cox.net>
References: <43571DA1.6030907@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 08:12:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESTe6-0004a3-6p
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 08:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbVJTGLT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 02:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbVJTGLT
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 02:11:19 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:50936 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751765AbVJTGLS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 02:11:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051020061119.GISK9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Oct 2005 02:11:19 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10351>

Wow.











That's elaborate.  And all this is to replace the beginning of
execute() part of daemon.c?  What I am assuming is that after
exchanging command-response initially, you still plan to
eventually have the protocol driver such as upload-pack to take
things over, once "send-pack <path>" is issued, but is my
assumption correct?  Or are you also thinking about redoing
upload-pack as well (otherwise you cannot issue 5.4 errors)?

I am wondering if we can just get away with a simpler scheme
Linus outlined instead.  One drawback of that approach is it
does not easily allow things like challenge-response uniformly
across different commands (admittedly we only have "upload-pack"
command right now, but we could add list of supported commands
easily in execute()), but you could do something along this, I
presume?

When daemon is started with --require-challenge-response,
the client needs to issue "challenge-me" command and complete
challenge_response successfully before being able to issue any
other commands.

NOTE: this is just an outline, not a compilable patch.  You need to
fill in the details of challenge response, definition of
"require_challenge_response" variable of type bool, and a
command line parsing to set that variable.


---

git diff
diff --git a/daemon.c b/daemon.c
index c3381b3..8a8746a 100644
--- a/daemon.c
+++ b/daemon.c
@@ -204,20 +204,55 @@ static int upload(char *dir)
 	return -1;
 }
 
-static int execute(void)
+static int challenge_response(const char *me)
 {
-	static char line[1000];
-	int len;
+	char line[1000];
 
-	alarm(init_timeout ? init_timeout : timeout);
+	packet_write(1, "here comes your challenge");
+
+	alarm(timeout);
 	len = packet_read_line(0, line, sizeof(line));
 	alarm(0);
 
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
 
-	if (!strncmp("git-upload-pack /", line, 17))
-		return upload(line+16);
+	if ("validate response we obtained in line here")
+		return 1;
+	return 0;
+}
+
+static int execute(void)
+{
+	static char line[1000];
+	int len;
+	int client_ok = !require_challenge_response;
+	unsigned int time_out = init_timeout;
+
+	while (1) {
+
+		alarm(time_out);
+		time_out = timeout;
+		len = packet_read_line(0, line, sizeof(line));
+		alarm(0);
+		if (len && line[len-1] == '\n')
+			line[--len] = 0;
+
+		if (!strncmp("challenge-me ", line, 13)) {
+			client_ok = challenge_response(line+13);
+			continue;
+		}
+
+		if (!client_ok)
+			break;
+
+		if (!strncmp("git-upload-pack /", line, 17))
+			return upload(line+16);
+
+		/* more commands here later */
+
+		break;
+	}
 
 	logerror("Protocol error: '%s'", line);
 	return -1;
