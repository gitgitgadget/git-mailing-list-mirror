From: "Jonas H." <jonas@lophus.org>
Subject: Re: Implementing authenticated Smart HTTP - which URLs to secure
Date: Mon, 16 Jul 2012 19:36:07 +0200
Message-ID: <50045107.1080608@lophus.org>
References: <5002C8F3.6080400@lophus.org> <CAJo=hJv=h-+OsV2K_8VeEdrHoFem-Z7x+tkE7TXj5pNO5LAeow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 19:36:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqpDU-0000nj-1M
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 19:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087Ab2GPRgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 13:36:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:58185 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab2GPRgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 13:36:09 -0400
Received: from v216570639.yourvserver.net (static.19.17.47.78.clients.your-server.de [78.47.17.19])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MGi3N-1T4Jcc2cdt-00DWC0; Mon, 16 Jul 2012 19:36:07 +0200
Received: from [192.168.1.2] (nat-wh-euh.rz.uni-karlsruhe.de [141.70.81.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by v216570639.yourvserver.net (Postfix) with ESMTPSA id 549BCDFAA78
	for <git@vger.kernel.org>; Mon, 16 Jul 2012 19:36:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120616 Thunderbird/13.0.1
In-Reply-To: <CAJo=hJv=h-+OsV2K_8VeEdrHoFem-Z7x+tkE7TXj5pNO5LAeow@mail.gmail.com>
X-Provags-ID: V02:K0:xaW/4bPBdKlPyQ/1HRj7761WEZuYfg+OrAmiRUaA0l7
 ysPctye2l1/fQBVINVOe0iqca6D1bbL9ALV8u7CKLXE7hc/4IS
 88SSVnoYnZjVjmIOJuCOBKVeqWQjoSiqzO0I6x+FXQc0AV8I3T
 uG0aNuT7oVRp2GDpE5izw+PW45BzvEUBkZepmmrmMXCUecr/Gp
 jYkhcc3RevFQ5Z/3rL1yxZaxm7fMQkMyzKxp8culrrrt0JyBxW
 Yhnblcwieli1WExgccj5v1pA6lhH0108Vxvyo87q3O3iM4VbkA
 QPDnpMJyT269sTOsa6LhEpLhi5JWYVb1Lyx0Uxa1LeVMB2UEE1
 dMYTvybH5U6DdyHE2KFtEmnkhoLwGo6xfVODLY0RM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201535>

On 07/15/2012 10:49 PM, Shawn Pearce wrote:
> On Sun, Jul 15, 2012 at 6:43 AM, Jonas H. <jonas@lophus.org> wrote:
>> I'd like to implement HTTP authentication for Git Smart HTTP using Dulwich
>> (a Python binding):
>>
>> 1) read-only if unauthenticated and write only if authenticated
>> 2) read/write only if authenticated
>>
>> I couldn't find any documentation on which URLs need be secured and what
>> response codes are expected in case the cloner/pusher is unauthenticated.
>
> Smart HTTP uses HTTP authentication, so return 401 with a proper
> WWW-Authenticate header to prompt the client for authentication, and
> use the Authorization header to verify the client. Return 403 to tell
> the client they cannot access the service because the Authorization
> header is invalid[1].
>
> You can tell check for a write request by looking at the service
> parameter on the /info/refs request, if its git-receive-pack, you are
> about to receive a write, so you want to prompt for authentication.
> You should also check for authentication on the /git-receive-pack
> request.

Thanks man! That helped a lot. I figured it has something to do with the 
argument to /info/refs but didn't make the connection between "I want to 
upload" and "git-receive-pack" -- it's pretty confusing that the 
argument is "receive" if I want to *upload*. At least when you don't 
know the argument is the name of the service the client wants the server 
to start.

> [1] This is actually a lie. The servers I have written over the years
> return 200 OK with a special Git payload in this case. The payload
> uses the "ERR" in the /info/refs response to print a message to the
> client telling the user access is forbidden. This allows a custom
> message to be sent, and stops the client from discarding the message
> and falling back to the dumb protocol.

I just experienced that exact problem. What worked for me is just 
keeping responding with 401 Unauthorized.  Git will give up with a nice 
error message ("Authentication failed") after a 2 or so tries.

Do you know of any better way that does not require using the raw Git 
protocol?

> There is no authentication/authorization in the server components in
> git-core. This is delegated to the web server that runs in front of
> Git, just like with the system SSH server handling authentication for
> Git over SSH.

Well that explains why I couldn't find anything helpful in the code :-) 
Though I'm a bit confused by the lack of documentation on the subject 
since I'm probably not the first one to set up a Git server with 
authentication?!

Jonas
