From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Revamping the git protocol
Date: Wed, 19 Oct 2005 21:31:29 -0700
Message-ID: <43571DA1.6030907@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 20 06:33:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESS5x-0004rL-FB
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 06:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbVJTEbj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 00:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbVJTEbj
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 00:31:39 -0400
Received: from terminus.zytor.com ([192.83.249.54]:55439 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751712AbVJTEbj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 00:31:39 -0400
Received: from [172.27.3.248] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9K4VWQU017843
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Oct 2005 21:31:36 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10344>

Okay, so I've started thinking about what it would take to revamp the 
git protocol.  What I came up with seems a little complex, but all it 
really is is take the framework that most successful Internet protocols 
have used and applied it to git.

Something else that I've noticed is that there is functionality overlap 
between git-daemon and git-send-pack, such as the namespace management 
(DWIM functionality.)  Additionally, even when using git over ssh there 
is the potential for version skew, so it might be worthwhile to run the 
full protocol over ssh as well.

Anyway, here is a strawman.  Items I feel unsure about I've put in brackets.

  ----------

1. "Strings" are sequences of bytes prefixed with a length.  The length 
is encoded as four lower-case hexadecimal digits.  [Why not as 2 or 4 
bytes of network byte order binary?]  When represented in this text as 
"foo", this means the sequence of bytes on the wire is <0003foo>.

2. Upon connection, the server will issue a sequence of strings, 
terminated by a null string.  The first string will be of the format:

"git <x.y>[ <hostname>]"

x.y is protocol revision (currently 1.0) with the following semantics:

- a change in x indicates a fully incompatible protocol change which 
means a client which doesn't understand the exact x version should 
immediately disconnect without issuing any output.

- a change in y indicates a backward-compatible protocol change which 
menas a client which understands an older version of the protocol can 
still communicate.

- hostname is an optional canonical name for this server.

For protocol version 1.0, subsequent strings are of the form:

"<R|O|I> option[ <parameters...>]"

... where the letter indicates REQUIRED, OPTIONAL or INFORMATIVE.  If a 
server specifies a REQUIRED option which the client does not understand 
or support, the CLIENT should terminate with an "unable" command (see 
below).  An OPTIONAL option is available to the client should it choose 
to accept it.  An INFORMATIVE option has no protocol function, but may 
be used to tune the client, inform the client of server policies (such 
as timeouts) or display to the end user if the client is in verbose mode.

Note that the addition of options does not require a new protocol 
revision.  It is generally believed that the protocol revision will 
rarely, if ever, be changed.

2a. Option "challenge":

     "R challenge <seed>"

... where 'seed' is any sequence of bytes means that the client should 
compute the SHA-1 of the seed and issue a "response" command with the 
SHA1 in hexadecimal form before issuing any other command.

3. After receiving the list of options, the client can issue commands. 
Commands are strings beginning with a command, one space, and any 
arguments as appropriate to the command.

4. The response to a command is a string beginning with a dot-separated 
sequence of numbers, one space, and an optional human-readable text 
string.  Each part of the dot-separated sequence refines the response; 
if a client receives "3.1.1.6 foo" and doesn't know what it is, but 
knows what a "3.1" response is, it should treat the 3.1.1.6 response as 
a 3.1 response.

If the server is closing the connection, the response is prefixed with 
the letter 'C':

"C5.0.1 Incorrect response"

Future versions of the protocol might define new prefix letters; if a 
client encounters unknown prefix letters they should be ignored.

2	- successful completion, closing connection
3	- successful initiation, begin transaction
4	- transient error
4.1	- server resource exhaustion errors
4.1.1	- load too high
5	- permanent error
5.1	- protocol errors
5.2	- authentication error
5.2.1	- invalid reponse to challenge option
5.3	- permission errors
5.3.1	- repository access denied
5.4	- data integrity error
5.4.1	- invalid or corrupt repository

5. Commands, and their responses:

"response <sha1>"

... response to a "challenge" option.  Responses:

"2.0 OK" - response accepted
"C5.2.1 Invalid response" - invalid response

"unable <human error message>"

... error message from the client to the server due to an unsupported R 
option.  Sending this message can inform the server administrator of 
version skew problems.

Response:

"C5.1.1 Too bad"

"send-pack <path>"

... begin synchronization of the repository at <path>.  Responses:

"3.1.1 Begin"
Any 4.1 response
Any 5.3 or 5.4 response


Clearly this needs to be fleshed out a bit more... is this total 
insanity on my part, or is this something worth doing?

	-hpa
