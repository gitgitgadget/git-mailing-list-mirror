From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Implementing authenticated Smart HTTP - which URLs to secure
Date: Sun, 15 Jul 2012 13:49:04 -0700
Message-ID: <CAJo=hJv=h-+OsV2K_8VeEdrHoFem-Z7x+tkE7TXj5pNO5LAeow@mail.gmail.com>
References: <5002C8F3.6080400@lophus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "Jonas H." <jonas@lophus.org>
X-From: git-owner@vger.kernel.org Sun Jul 15 22:50:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqVlS-0007ud-6v
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 22:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab2GOUt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 16:49:27 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62603 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978Ab2GOUtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 16:49:25 -0400
Received: by vcbfk26 with SMTP id fk26so494046vcb.19
        for <git@vger.kernel.org>; Sun, 15 Jul 2012 13:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nyPN3Z1n1evJ7j0w7abqM7evGSXTmGUTM7dID+z8a7k=;
        b=B3nLgufy/BMDjYvSxztrkLVvrHs+yW07eaRP6Fc2kZ7Y6/lvPmH2MGJsjOMV8YIo9P
         3dIbZS6fAHo5kKzEEtCz8BHumh2sXD5YfBw2sSujiqh3BKSZvw3Q6hXoaMDCbSal0oli
         pPdVZeQ9BGmyFo/wpLmXgmbS8UlHGdMAux0vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=nyPN3Z1n1evJ7j0w7abqM7evGSXTmGUTM7dID+z8a7k=;
        b=AfEP4PhtoMhoilmoXEnVSkerSzdCbitz5DpZzImmdPmka+zOaH40Ex7P2YzjCeiy4/
         UIdUHVCBxewDSNCt6N2LrvvNAEM7l0J45oYPvKMfiWxyxdu2kHgazECp2evsIzA7riuy
         STJm9MvC+rVGgySq/zG0GKT7HoOG66XJFkkBuyY8GcnF+4eaq7Bfnu3jQ68LLI3T27yu
         nKJ1xfK/2xrK7UTWLWWJpPJ/tYnPQKcgHqZZKzO5mda6YjCkcSkN89CP/B9nKJnQ4Vhz
         B+l7BrDZ6DnkGk8k26uuZz399D1BxGdUq5+jWeKAK3m6QoOL5tbAlS8hJKzLHEpNlRC8
         MT5A==
Received: by 10.52.73.42 with SMTP id i10mr3562841vdv.116.1342385364565; Sun,
 15 Jul 2012 13:49:24 -0700 (PDT)
Received: by 10.52.158.137 with HTTP; Sun, 15 Jul 2012 13:49:04 -0700 (PDT)
In-Reply-To: <5002C8F3.6080400@lophus.org>
X-Gm-Message-State: ALoCoQkX3ywwZGYphZBFhZIFIB7W1KrcOyK5DKw4zIFZWBgcgVIH0XGJxHvDVEy2QVHLkx1bQhA5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201483>

On Sun, Jul 15, 2012 at 6:43 AM, Jonas H. <jonas@lophus.org> wrote:
> I'd like to implement HTTP authentication for Git Smart HTTP using Dulwich
> (a Python binding):
>
> 1) read-only if unauthenticated and write only if authenticated
> 2) read/write only if authenticated
>
> I couldn't find any documentation on which URLs need be secured and what
> response codes are expected in case the cloner/pusher is unauthenticated.

Smart HTTP uses HTTP authentication, so return 401 with a proper
WWW-Authenticate header to prompt the client for authentication, and
use the Authorization header to verify the client. Return 403 to tell
the client they cannot access the service because the Authorization
header is invalid[1].

You can tell check for a write request by looking at the service
parameter on the /info/refs request, if its git-receive-pack, you are
about to receive a write, so you want to prompt for authentication.
You should also check for authentication on the /git-receive-pack
request.

[1] This is actually a lie. The servers I have written over the years
return 200 OK with a special Git payload in this case. The payload
uses the "ERR" in the /info/refs response to print a message to the
client telling the user access is forbidden. This allows a custom
message to be sent, and stops the client from discarding the message
and falling back to the dumb protocol.

> Is there any documentation on Smart HTTP workflow?  The C sources (vanilla
> Git and libgit2) didn't help me too much since I found it very difficult to
> follow the code-flow... it's probably just abstracted too well :-)

There is no authentication/authorization in the server components in
git-core. This is delegated to the web server that runs in front of
Git, just like with the system SSH server handling authentication for
Git over SSH.
