From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: [PATCH v3] Add git-grep threads param
Date: Tue, 27 Oct 2015 06:54:16 -0700
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9FF@mail.accesssoftek.com>
References: <1445862733-838-1-git-send-email-vleschuk@accesssoftek.com>
 <20151026193241.GO19802@serenity.lan>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9FC@mail.accesssoftek.com>,<20151027115256.GQ19802@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Victor Leschuk <vleschuk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Oct 27 14:54:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr4hi-0006t0-8V
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 14:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbbJ0NyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 09:54:18 -0400
Received: from mail.accesssoftek.com ([12.202.173.171]:9661 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932390AbbJ0NyR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2015 09:54:17 -0400
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Tue, 27 Oct 2015 06:54:16 -0700
Thread-Topic: [PATCH v3] Add git-grep threads param
Thread-Index: AdEQrg7tstW6NcujSDepDBa5XxXcVgADz8my
In-Reply-To: <20151027115256.GQ19802@serenity.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280263>

Hello John,

>> This thought also crossed my mind, however we already pass grep_opt to
>> start_threads() function, so I think passing it to wait_all() is not
>> that ugly, and kind of symmetric. And I do not like the idea of
>> duplicating same information in different places. What do you think?

> The grep_opt in start_threads() is being passed through to run(), so it
> seems slightly different to me.  If the threads were being setup in
> grep.c (as opposed to builtin/grep.c) then I'd agree that it belongs in
> grep_opt, but since this is local to this particular user of the grep
> infrastructure adding num_threads to the grep_opt structure at all feels
> wrong to me.

> Note that I wasn't suggesting passing num_threads as a parameter to
> wait_all(), but rather having it as global state that is accessed by
> wait_all() in the same way as the `threads` array.

> If we rename use_threads to num_threads and just use that, then we only
> have the information in one place don't we?

Yeah, I understood your idea. So we parse config_value directly to 

static int num_threads; /* old use_threads */

And use it internally in builtin/grep.c. I think you are right.

Looks like grep_cmd_config() is the right place to parse it. Something like:

--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -267,6 +267,8 @@ static int wait_all(struct grep_opt *opt)
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
        int st = grep_config(var, value, cb);
+       if (thread_config(var, value, cb) < 0)
+               st = -1;
        if (git_color_default_config(var, value, cb) < 0)
                st = -1;
        return st;

What do you think?

--
Best Regards,
Victor
