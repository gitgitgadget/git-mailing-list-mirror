From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] gitweb: return correct HTTP status codes
Date: Mon, 16 Jun 2008 17:57:16 +0200
Message-ID: <48568D5C.5090909@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com> <m37icqpb5f.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 17:58:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8H60-0002s6-HR
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 17:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbYFPP5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 11:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754081AbYFPP5V
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 11:57:21 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:31750 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbYFPP5U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 11:57:20 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3393770fkq.5
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 08:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=w3zC5buoybpQJqQuC+v5nNTnl3TG8Fo8xo2A2twKUWA=;
        b=QQSXB+SdEdRZXYS5WoAQuOvwNkG4HuItXSNrB2TzZe2U4/l7Uruj8Zg+mdEjEUv0S+
         1zeXrua2sjI6OMtS50IejxMMFI9TueRo6et/G3y6T9TWU8WdqK/X7EBSUCkbpNu2Snnp
         N/tJlKZ/70kTtdeGB54H3Gpp5/sI87wRE0dPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=KpTzi+eFKt9laToVRwkQUCRXrjxj0J4Sn9sjoD+5s+BaUFmfBT2w/LyU2BR1hg30B2
         jgVtYbXWH34VMbN3NArr/wSIo4HrWaoKemEZSH34WbuEXeAvJ8pCN7zYxdbHn42zorZ5
         kugUHx7PbjfoiAIKPShCPsFhdNsLCxHt7//Ns=
Received: by 10.78.173.5 with SMTP id v5mr2692656hue.119.1213631838408;
        Mon, 16 Jun 2008 08:57:18 -0700 (PDT)
Received: from ?172.16.30.128? ( [84.181.171.31])
        by mx.google.com with ESMTPS id p28sm4115212hub.29.2008.06.16.08.57.17
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 08:57:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <m37icqpb5f.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85197>

Jakub Narebski wrote:
> [Subject:] I would perhaps choose "gitweb: standarize HTTP status codes"

Will fix if there's a follow-up patch.

> I'd like to have reasoning when, and why, we use which responses (HTTP
> status codes) in which situations.  Link to appropriate RFC you used
> (and perhaps to some other information)

RFC 2616 has clear descriptions of the codes we use.  Maybe a really
short list of conventions though, like you listed below?  If we have
agreement I'll happily put it in.

>> For convenience the die_error function now only takes the status code
>> without reason as first parameter
> 
> Well, gitweb sometimes used different wording

The 'reason' only appeared in the HTTP response header -- see below.

>> I recommend that you apply [PATCH] gitweb: remove git_blame
> 
> I think it is not possible, as IIRC [it] got already applied.

It isn't applied on master (at the time I'm writing this), only on next.
Should I be working on the next branch?

>>  	open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
>> -		or die_error(undef, "Open git-ls-tree failed");
>> +		or die_error(500, "Open git-ls-tree failed");
> 
> Should we really use "500 Internal Server Error" here?  Usually this
> would be not an error at all, but wrong parameters to git command,
> i.e. it is _user_ who erred, not some error on _server_ side.

You cannot tell for sure -- all you know here is that the command
somehow failed when it shouldn't have, and so all you can give is 500;
see below.  I don't think we should apply reasoning like "most commonly
it's a wrong hash, so let's return 404" -- we don't know, and we
shouldn't assume.

>> ... I suspect that the error could be triggered by non-existent hashes
>> as well, in which case the more specific 404 would be more appropriate
>> -- however, the current implementation oftentimes doesn't allow for
>> more fine-granulared checking
> 
> ...that is why I'd rather have "403 Forbidden" as catch-all error, as
> it was done in gitweb.  But that also seems not very good idea.

[IANA HTTP expert, but:] All we have in cases like the one above is "I
cannot deliver the content you requested, but I'm so confused that I
don't even know why" -- which sounds like 500 to me (definitely not
403).  403 would be used for some deactivated feature (commonly for
disabled directory listings I think) or something that shouldn't be
accessible to the public.

>>  sub die_error {
>> -	my $status = shift || "403 Forbidden";
>> -	my $error = shift || "Malformed query, file missing or permission denied";
>> +	my $status = shift || 500;
>> +	my $error = shift || "Internal server error";
> 
> Errr, I think "Malformed query, file missing or permission denied" is
> actually closer to truth,  and better error message

This default is intended for expressions like "some_action(...) or
die_error" (without parameters), in which case you really can't tell
what triggered the error, so "Internal server error" is as specific as
you can get.

> (it is displayed in body of message)

Just to make sure we're on the same boat, the $error variable above *is*
what's displayed in the body.

>> +	# Use a generic "Error" reason, e.g. "404 Error" instead of
>> +	# "404 Not Found".  This is permissible by RFC 2616.
>> +	git_header_html("$status Error");
> 
> I don't think it is _recommended_ practice.  IIRC it is recommnded
> [...] to give more detailed explanation in the body of message.

The code above prints the HTTP response headers, not the body -- the
body contains the detailed error message passed to the die_error
function.  Here's a stripped down version of gitweb's error response 
(X'ed out against spam filter):

HTXTP/1.0 404 Error   <------------ "Error" here
CoXntent-Type: text/htXml

... 404 - Hash not found ...

I don't know of *any* browser or tool that actually displays the reason
given in the HTTP response header, so defaulting to Error is fine here
(especially since RFC 261 explicitly allow it).

(I don't want to put the $error passed to die_error into the HTTP
response header, since badly interpolated strings might invalidate the
response.  So using "Error" makes sure we always die gracefully.)

> Proposed HTTP server/client error status codes [heavily snipped]:
> 
> 1. Basic CGI parameter validation; 400 or perhaps 404 as catch-all

Yes, 400 is appropriate here; I don't think there are any catch-all
cases to catch. :)

> 2. Gitweb cannot find requested resource: 404 Not Found
> 3. Some required parameters are missing: 400 Bad Request
> 5. When some feature is requested that is not enabled, but with
>    different gitweb configuration would be available: 403

Yup, that's what I used.

> 4. Project list is requested, but there are no projects (or no forks)
>    to be displayed by gitweb: not sure [...].  I don't think that 
>    "404 Not Found" would be good solution...

I see three possibilities:

404: "I couldn't find any projects/forks."
500: "The admin didn't set this up properly" (doesn't apply to forks)
200: "Here's the list your requested (it's empty though)."

Since 500 doesn't work for forks, and since 200 requires additional code
in order to not display an error page (which should be done in a
separate patch, with tests), 404 seemed like a reasonable default to me. 
It's better than the previous 403, so it's not a regression.

> 6. Request is made for a wrong type of object, for example 'blame' on
>    object which is not a blob: 400 (if not 404).

Yup.  I wasn't sure, but I used 400 since it seemed a little more
appropriate ("you asked me for an invalid action on this object").

> 7. When the git command failed, and we don't know the reason...

... 500 (see above). :)


 > Could you please Cc me if you address me in email?

Will do.

 > probably me, Petr Baudis, John Hawley, perhaps Luben Tuikov

I wouldn't want to Cc people if I don't address them personally -- e.g.
neither Petr nor John are currently working on gitweb, so flooding their
mailboxes might seem a little rude; if they're interested they can
always filter for subjects.  (Unless someone requests to always be CC'ed
of course.)

-- Lea
