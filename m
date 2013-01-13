From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/8] git_remote_helpers: fix input when running under
 Python 3
Date: Sun, 13 Jan 2013 16:17:24 +0000
Message-ID: <20130113161724.GK4574@serenity.lan>
References: <cover.1358018078.git.john@keeping.me.uk>
 <a8c3aabfab64f49fa0cbb2d45bda79997a875ee8.1358018078.git.john@keeping.me.uk>
 <50F2296F.8030909@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jan 13 17:18:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuQFx-0004er-RC
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 17:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179Ab3AMQRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 11:17:38 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:44475 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab3AMQRh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 11:17:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9F75ECDA5D1;
	Sun, 13 Jan 2013 16:17:36 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1bIDHCciUDIU; Sun, 13 Jan 2013 16:17:34 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by jackal.aluminati.org (Postfix) with ESMTP id C9519CDA57C;
	Sun, 13 Jan 2013 16:17:34 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id 98CAD276DFB;
	Sun, 13 Jan 2013 16:17:34 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5E63NpErJvRb; Sun, 13 Jan 2013 16:17:34 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id 075CD330872;
	Sun, 13 Jan 2013 16:17:26 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <50F2296F.8030909@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213384>

On Sun, Jan 13, 2013 at 04:26:39AM +0100, Michael Haggerty wrote:
> On 01/12/2013 08:23 PM, John Keeping wrote:
>> Although 2to3 will fix most issues in Python 2 code to make it run under
>> Python 3, it does not handle the new strict separation between byte
>> strings and unicode strings.  There is one instance in
>> git_remote_helpers where we are caught by this.
>> 
>> Fix it by explicitly decoding the incoming byte string into a unicode
>> string.  In this instance, use the locale under which the application is
>> running.
>> 
>> Signed-off-by: John Keeping <john@keeping.me.uk>
>> ---
>>  git_remote_helpers/git/importer.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
>> index e28cc8f..6814003 100644
>> --- a/git_remote_helpers/git/importer.py
>> +++ b/git_remote_helpers/git/importer.py
>> @@ -20,7 +20,7 @@ class GitImporter(object):
>>          """Returns a dictionary with refs.
>>          """
>>          args = ["git", "--git-dir=" + gitdir, "for-each-ref", "refs/heads"]
>> -        lines = check_output(args).strip().split('\n')
>> +        lines = check_output(args).decode().strip().split('\n')
>>          refs = {}
>>          for line in lines:
>>              value, name = line.split(' ')
>> 
> 
> Won't this change cause an exception if the branch names are not all
> valid strings in the current locale's encoding?  I don't see how this
> assumption is justified (e.g., see git-check-ref-format(1) for the rules
> governing reference names).

Yes it will.  The problem is that for Python 3 we need to decode the
byte string into a unicode string, which means we need to know what
encoding it is.

I don't think we can just say "git-for-each-ref will print refs in
UTF-8" since AFAIK git doesn't care what encoding the refs are in - I
suspect that's determined by the filesystem which in the end probably
maps to whatever bytes the shell fed git when the ref was created.

That's why I chose the current locale in this case.  I'm hoping someone
here will correct me if we can do better, but I don't see any way of
avoiding choosing some encoding here if we want to support Python 3
(which I think we will, even if we don't right now).


John
