From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: What's cooking in git.git (Mar 2010, #06; Wed, 24)
Date: Thu, 25 Mar 2010 11:27:33 -0500
Message-ID: <25yNvbuAivZlBuEJoRhXtfoEc7HEZorM5qOrwgQKk7FER_fdzljyMQ@cipher.nrlssc.navy.mil>
References: <7v7hp1kzbn.fsf@alter.siamese.dyndns.org> <fcaeb9bf1003250811g777b2881l332e6f61456d699@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 20:52:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nut6k-00032h-Kw
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 20:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab0CYTwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 15:52:40 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44906 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368Ab0CYTwk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 15:52:40 -0400
Received: by mail.nrlssc.navy.mil id o2PJieUZ027036; Thu, 25 Mar 2010 14:47:07 -0500
In-Reply-To: <fcaeb9bf1003250811g777b2881l332e6f61456d699@mail.gmail.com>
X-OriginalArrivalTime: 25 Mar 2010 16:27:33.0137 (UTC) FILETIME=[12567010:01CACC38]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143196>

On 03/25/2010 10:11 AM, Nguyen Thai Ngoc Duy wrote:
> 2010/3/25 Junio C Hamano <gitster@pobox.com>:
>> * ar/config-from-command-line (2010-03-19) 1 commit
>>  - Allow passing of configuration parameters in the command line
>>
>> * bc/t5505-fix (2010-03-19) 3 commits
>>  - t/t5505-remote.sh: escape * to prevent interpretation by shell as glob
>>  - t5505: add missing &&
>>  - t5505: remove unnecessary subshell invocations

methinks you were over-aggressive with your cut/paste?  I don't think bc/t5505-fix
contains a strndup.  Hopefully, it does not break your build on Solaris.

> This breaks my build on Solaris because it uses strndup, which is not available.

A quick glance at ar/config-from.. also detected an unchecked calloc().

Alex, any reason xcalloc wasn't used?

btw, me also thinks the code is a little hard to read.  For example, I initially
thought your calloc was not allocating enough space for the nul terminator.

   ct = calloc(1, sizeof(struct config_item) + (text - name));
   memcpy(ct->name, name, text - name);

I traced the code, but it wasn't until I noticed that your data structure looks
like this:

   struct config_item
   {
          struct config_item *next;
          char *value;
          char name[1];
   };

that I realized that room for the nul terminator in the 'name' array was allocated
by the structure itself, since the name declaration looks like name[1] and not
name[FLEX_ARRAY].

Would the code be simpler if strbufs were used?  Then you wouldn't need to duplicate
the skip_space and trailing_space functionality provided in the strbuf library, and
would just need a new function named strbuf_tolower.

Also, should config_parametes_tail be spelled config_parameters_tail?

-brandon
