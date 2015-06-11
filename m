From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clone: check if server supports shallow clones
Date: Thu, 11 Jun 2015 20:02:33 +0700
Message-ID: <CACsJy8CiwiWgf2CarNNN5NgN7QbRB8oxGMmxF+VX8T=ZV2M1ow@mail.gmail.com>
References: <1433961320-1366-1-git-send-email-adgar@google.com> <20150610190512.GB22800@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Edgar <adgar@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 11 15:03:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z328X-00085H-F5
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 15:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501AbbFKNDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 09:03:08 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:32822 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbbFKNDE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 09:03:04 -0400
Received: by igbpi8 with SMTP id pi8so54090013igb.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 06:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=d080hWWH48uPXV/ShCFNHHGINpBfKm7HVUN7wBJpxb4=;
        b=KONGvtSQ66PkhxXpPrA8H93J+wglZEgRRq5olzqO2ChdKT4ACgzqhTjiwt55l3rPoe
         lgY7GF+NEziXp4A0XpR0mgeA1kAHZ9pcUMeHhepXScy41eYT5weStdsO+nxPjbt3VvU0
         qV/fKTAAA+VfBfMLBveT/Yl1o15egncXhAKsuP0OwLkFv+cswZ5hvqxl9tkneLL9mVa9
         +Kg/wTtOO/FOBTc3gm4SyPZfAiOvzhkGgU5FbvgCYAT0+/A8W4cBSYqAz3WXllr/HjIu
         XcNznmxVylprQC8Xkl7wVdQm+ZTS4fNSVdxNurPat8hoQvu9JuAPZewmJn7ucB02c3/8
         DbfA==
X-Received: by 10.43.172.68 with SMTP id nx4mr10511093icc.48.1434027783758;
 Thu, 11 Jun 2015 06:03:03 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Thu, 11 Jun 2015 06:02:33 -0700 (PDT)
In-Reply-To: <20150610190512.GB22800@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271403>

On Thu, Jun 11, 2015 at 2:05 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Jun 10, 2015 at 02:35:20PM -0400, Mike Edgar wrote:
>
>> When the user passes --depth to git-clone the server's capabilities are
>> not currently consulted. The client will send shallow requests even if
>> the server does not understand them, and the resulting error may be
>> unhelpful to the user. This change pre-emptively checks so git-clone can
>> exit with a helpful error if necessary.
>
> This sounds like a good thing to do, but...
>
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -944,6 +944,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>
>>       refs = transport_get_remote_refs(transport);
>>
>> +     if (option_depth && !is_local && !server_supports("shallow"))
>> +             die(_("Server does not support shallow clients"));
>> +
>
> It feels a little weird to be checking the option here in cmd_clone.
> The transport layer knows we have specified a depth, so it seems like a
> more natural place for it (or possibly even lower, in the actual
> git-protocol code).
>
> That being said, I think the current capabilities handling is a bit
> messy and crosses module boundaries freely. So I would not be surprised
> if this is the most reasonable place to put it. But it does make me
> wonder whether "git fetch --depth=..." needs the same treatment.
>
> I see that do_fetch_pack checks server_supports("shallow"). Is that
> enough to cover all fetch cases? And if it is, why does it not cover the
> matching clone cases?

I think this replacement check would do

if ((args->depth > 0 || is_repository_shallow()) && !server_supports("shallow"))
        die("Server does not support shallow clients");
-- 
Duy
