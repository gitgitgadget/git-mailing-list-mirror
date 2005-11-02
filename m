From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 4/4] git-daemon support for user-relative paths.
Date: Wed, 02 Nov 2005 09:17:18 +0100
Message-ID: <4368760E.6030208@op5.se>
References: <20051101225921.3E7455BF74@nox.op5.se> <7vvezb6h4c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 02 09:18:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXDoB-0000Ex-8f
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 09:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbVKBIRU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 03:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbVKBIRU
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 03:17:20 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:4334 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932638AbVKBIRT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 03:17:19 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id E752C6BD00
	for <git@vger.kernel.org>; Wed,  2 Nov 2005 09:17:18 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vvezb6h4c.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11005>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>+             [--timeout=n] [--init-timeout=n] [--strict-paths] [directory...]
> 
> 
> Why not just --strict?
> 
> 
>>@@ -10,16 +10,18 @@
>> #include "pkt-line.h"
>> #include "cache.h"
>> 
>>-static int log_syslog;
>>+static int log_syslog = 0;
> 
> 
> I'd drop this.
> 

No can do. It has to be set either here or down in main. It's nice to 
have the default in the declaration.

> 
>> /* If this is set, git-daemon-export-ok is not required */
>> static int export_all_trees = 0;
>> 
>>@@ -81,69 +83,49 @@ static void loginfo(const char *err, ...
>> 	va_end(params);
>> }
>> 
>>-static int path_ok(const char *dir)
>>+static const char *path_ok(const char *dir)
>> {
>>+	const char *path = is_git_repo(dir, strict_paths);
>>+	/* No such directory or not a git archive */
>>+	if(!path) {
>>+		logerror("'%s': unable to chdir or not a git archive", dir);
>>+		return NULL;
>> 	}
>> 
>> 	if ( ok_paths && *ok_paths ) {
>>+		char **pp = NULL;
>>+		int dirlen = strlen(path);
>> 
>> 		for ( pp = ok_paths ; *pp ; pp++ ) {
>> 			int len = strlen(*pp);
>>+			if ( len <= dirlen && !strncmp(*pp, path, len) ) {
>>+				if( path[len] == '\0' || (!strict_paths && path[len] == '/') )
>>+					return path;
>> 			}
>> 		}
> 
> 
> Sorry, but I am a bit confused.  Does this mean that you need to
> list all directories under --strict-paths, instead of saying
> "/pub/scm and everything under it is OK"?
> 

Only if --strict-paths is set, otherwise it works as usual. It's 
documented in the man-page, but perhaps it's a bit too paranoid.

> I like the general direction this set is taking, but let's let
> it simmer for a while.
> 

Ok. I'll take that to mean "hold off on the --server-root and --userdir 
patch for a while" then.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
