From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/8] Handle more shell metacharacters in editor names
Date: Fri, 30 Oct 2009 05:25:48 -0500
Message-ID: <20091030102548.GC1610@progeny.tock>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock>
 <20091029075021.GC15403@progeny.tock>
 <7v8weu6idl.fsf@alter.siamese.dyndns.org>
 <20091030101634.GA1610@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 11:15:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3oWE-0003eM-VT
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 11:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812AbZJ3KPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 06:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756803AbZJ3KPc
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 06:15:32 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:50096 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756796AbZJ3KPc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 06:15:32 -0400
Received: by yxe17 with SMTP id 17so2535804yxe.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TK3xj+VgUlkeRhMSaMFTJ4Z115kE3c/0vJ2PAxagIgE=;
        b=AB4KsH9B7GIiitwsCpp+9JR6zQEPbSZ4+dRLfwqxZnbiv92PZ5ZJfkazkuBs/3ydT/
         dDiKmksiQcMxOiDNyndk3aoJgbXG1w8yI62enMBSu9efHYCoUc4hh5My1KiprmHkVUJu
         /KzFHfhnccJqx0hwG4c6gcrgkbyzADPvHXjIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ufrg5aOWbg5GfcWMhtW/jQtVUmeY6g1bZw3vTw9ofaCBUAhf5O+Ed90u2l/MZunyT4
         X3NfHs3aFjPI3HfOK6kD4gxpvRuOrzSvgmlAQVJjpiZRtRvmlMsoSb54lrTtVqQi4fy3
         xDHIbS7DjninNsxAuQXsiejFnh5Wd3rw9OsBM=
Received: by 10.90.10.9 with SMTP id 9mr3893322agj.69.1256897737114;
        Fri, 30 Oct 2009 03:15:37 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1295542yxe.20.2009.10.30.03.15.36
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 03:15:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091030101634.GA1610@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131686>

Pass the editor name to the shell if it contains any susv3 shell
special character (globs, redirections, variable substitutions,
escapes, etc).  This way, the meaning of some characters will not
meaninglessly change when others are added, and git commands
implemented in C and in shell scripts will interpret editor names
in the same way.

This does not make the GIT_EDITOR setting any more expressive,
since one could always use single quotes to force the editor to
be passed to the shell.

Signed-off-by: Jonathan Nieder<jrnieder@gmail.com>
---
 editor.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/editor.c b/editor.c
index 316d139..facd7f2 100644
--- a/editor.c
+++ b/editor.c
@@ -34,7 +34,7 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		const char *args[6];
 		struct strbuf arg0 = STRBUF_INIT;
 
-		if (strcspn(editor, "$ \t'") != len) {
+		if (strcspn(editor, "|&;<>()$`\\\"' \t\n*?[#~=%") != len) {
 			/* there are specials */
 			strbuf_addf(&arg0, "%s \"$@\"", editor);
 			args[i++] = "sh";
-- 
1.6.5.2
