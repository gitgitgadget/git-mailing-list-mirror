From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v5 12/10] remote-bzr: support the new 'force' option
Date: Mon, 11 Nov 2013 13:12:47 -0500
Message-ID: <52811E1F.4090500@bbn.com>
References: <1383212197-14259-2-git-send-email-felipe.contreras@gmail.com> <1384146656-11811-1-git-send-email-rhansen@bbn.com> <5280c4bc4354a_36a51059e74ea@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: srabbelier@gmail.com
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 19:13:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfvz2-0004ow-87
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 19:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106Ab3KKSMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 13:12:50 -0500
Received: from smtp.bbn.com ([128.33.0.80]:43611 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753572Ab3KKSMt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 13:12:49 -0500
Received: from socket.bbn.com ([192.1.120.102]:57675)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vfvyi-000Dpa-9S; Mon, 11 Nov 2013 13:12:48 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id ECAEF3FEF1
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <5280c4bc4354a_36a51059e74ea@nysa.notmuch>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237623>

On 2013-11-11 06:51, Felipe Contreras wrote:
> Richard Hansen wrote:
>> Signed-off-by: Richard Hansen <rhansen@bbn.com>
>> ---
>>  contrib/remote-helpers/git-remote-bzr | 34 +++++++++++++++++++++++++++++++++-
>>  contrib/remote-helpers/test-bzr.sh    | 22 +++++++++++++++++++++-
>>  2 files changed, 54 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
>> index 7e34532..ba693d1 100755
>> --- a/contrib/remote-helpers/git-remote-bzr
>> +++ b/contrib/remote-helpers/git-remote-bzr
>> @@ -42,6 +42,7 @@ import json
>>  import re
>>  import StringIO
>>  import atexit, shutil, hashlib, urlparse, subprocess
>> +import types
>>  
>>  NAME_RE = re.compile('^([^<>]+)')
>>  AUTHOR_RE = re.compile('^([^<>]+?)? ?[<>]([^<>]*)(?:$|>)')
>> @@ -684,7 +685,8 @@ def do_export(parser):
>>                  peer = bzrlib.branch.Branch.open(peers[name],
>>                                                   possible_transports=transports)
>>                  try:
>> -                    peer.bzrdir.push_branch(branch, revision_id=revid)
>> +                    peer.bzrdir.push_branch(branch, revision_id=revid,
>> +                                            overwrite=force)
>>                  except bzrlib.errors.DivergedBranches:
>>                      print "error %s non-fast forward" % ref
>>                      continue
>> @@ -718,8 +720,34 @@ def do_capabilities(parser):
>>          print "*import-marks %s" % path
>>      print "*export-marks %s" % path
>>  
>> +    print "option"
>>      print
>>  
>> +class InvalidOptionValue(Exception):
>> +    pass
>> +
>> +def do_option(parser):
>> +    (opt, val) = parser[1:3]
>> +    handler = globals().get('do_option_' + opt)
>> +    if handler and type(handler) == types.FunctionType:
>> +        try:
>> +            handler(val)
>> +        except InvalidOptionValue:
>> +            print "error '%s' is not a valid value for option '%s'" % (val, opt)
>> +    else:
>> +        print "unsupported"
>> +
>> +def do_bool_option(val):
>> +    if val == 'true': ret = True
>> +    elif val == 'false': ret = False
>> +    else: raise InvalidOptionValue()
>> +    print "ok"
>> +    return ret
>> +
>> +def do_option_force(val):
>> +    global force
>> +    force = do_bool_option(val)
>> +
> 
> While this organization has merit, I think it's overkill for a single option,
> or just a couple of them. If in the future we add more, we might revisit this,
> for the moment something like this would suffice:

OK, I'll reroll.

> 
>     class InvalidOptionValue(Exception):
> 	pass
> 
>     def get_bool_option(val):
> 	if val == 'true':
> 	    return True
> 	elif val == 'false':
> 	    return False
> 	else:
> 	    raise InvalidOptionValue()
> 
>     def do_option(parser):
> 	global force
> 	_, key, value = parser.line.split(' ')

I'm surprised you prefer this over 'key, val = parser[1:3]' or even
'_, key, val = parser[:]'.  Are you intending to eventually remove
Parser.__getitem__()?

Thanks,
Richard


> 	try:
> 	    if key == 'force':
> 		force = get_bool_option(value)
> 		print 'ok'
> 	    else:
> 		print 'unsupported'
> 	except InvalidOptionValue:
> 	    print "error '%s' is not a valid value for option '%s'" % (value, key)
> 
> Cheers.
