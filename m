From: Andy Whitcroft <apw@shadowen.org>
Subject: remote_get_heads: reference length limit
Date: Tue, 05 Sep 2006 13:50:37 +0100
Message-ID: <44FD729D.4020208@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 05 14:51:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKaOP-0004uO-IR
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 14:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWIEMvB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 08:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWIEMvA
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 08:51:00 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:62221 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S964795AbWIEMvA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 08:51:00 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GKaNw-0003Gv-Ov
	for git@vger.kernel.org; Tue, 05 Sep 2006 13:50:36 +0100
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26476>

I've been having trouble with git push apparently resending the entire
commit trace for the branch each and every time I push.  Poking at the
source it seems this is due to a length limit on reference names as
pulled from the remote repository.

When we are building the pack to send we are sent a list of remote
heads.  get_remote_heads() reads these in, validates them and finally
adds them to the remote_refs list.  Part of the validation is a simple
check for size and form; check_ref().

static int check_ref(const char *name, int len, unsigned int flags)
{
        if (!flags)
                return 1;

        if (len > 45 || memcmp(name, "refs/", 5))
                return 0;
[...]
}

With the refs/heads/ prefix included this limits the head names to 34
characters.  From what I can see there is no good reason for this limit
to be so low.  I can see we don't want the remote end bloating us out of
control, but we are already limiting the lines which contain these
references to 1000 bytes and making no attempt to limit the number of
them the remote server can send us.  There seems to be no limits imposed
on the name length other than MAX_PATHLEN.

Can anyone see a reason to keep this (len > 45) check?

-apw
