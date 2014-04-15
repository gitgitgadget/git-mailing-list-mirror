From: Delcypher <delcypher@gmail.com>
Subject: Re: [PATCH] git-remote-hg : Enable use of, $GIT_DIR/hg/origin/clone/.hg/hgrc
Date: Tue, 15 Apr 2014 16:37:23 +0100
Message-ID: <CANNJ_zjVaymTUmSSFHfSpmcH7H2v62nsHaUoxRfi098zqLi_Ow@mail.gmail.com>
References: <53076DFC.1000602@gmail.com>
	<53499bb02c140_285f9032ec58@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 17:37:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wa5QS-0002D3-0L
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 17:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbaDOPh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 11:37:26 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:49927 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbaDOPhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 11:37:25 -0400
Received: by mail-vc0-f170.google.com with SMTP id hu19so9439935vcb.15
        for <git@vger.kernel.org>; Tue, 15 Apr 2014 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=H1V+6FeXLWdREsMAqSyOyQE7BjsViD9u4eeWZF7+5Ug=;
        b=nNizupiTH5I68WACsBHgLl7jeCwMxqeKV2e21zfe0uozCk1nEKFeiPV3JSMlYz3tQw
         geIX4BlGsvkl9nBereK264DdADrduik8rw5hcjSRRsXrZ7nxyH5N8vFC+NoINXEwboqN
         HYSh5+Ut0a/SlM2sCjoKCe6u2c7WZPjP4gIgPxu2kVHha1UNVfXLn3nIZ4jEl6ZTJkOT
         isteSOQHdgUG00RVs4XGSv7XY8sp02ChOD8THFQOW20H2h2Ht4MJkkj8tADAW6YDC0zb
         TqUhtm4Ym68qpLAHvPQvKU5RzDi7r4vBTYe5MsHqsO6gyzZ8vZU1sxtErulP6KcrshAq
         O8Ww==
X-Received: by 10.52.237.228 with SMTP id vf4mr420525vdc.47.1397576244167;
 Tue, 15 Apr 2014 08:37:24 -0700 (PDT)
Received: by 10.220.88.70 with HTTP; Tue, 15 Apr 2014 08:37:23 -0700 (PDT)
In-Reply-To: <53499bb02c140_285f9032ec58@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246287>

> What is the problem you are trying to solve?
The problem I was trying to solve is I wanted my authentication
details to be in a hgrc local to the repository.

The problem is git-remote-hg will parse
``.git/hg/origin/clone/.hg/hgrc`` but will ignore any settings in it
(this seems a little silly).
You can see that git-remote-hg parses this by placing invalid syntax
in the file.

> Is there a way to test that this
> code is working correctly?

The effects are much more obvious if you use a mercurial repository
that uses https and then you try to push to it with authentication
details in ``.git/hg/origin/clone/.hg/hgrc``. For example

[auth]
cc.prefix = hg.codeplex.com
cc.username = USERNAME
cc.password = PASSWORD
cc.schemes = https

pushing will fail because the authorisation details get completely
ignored and you will get an exception raised with a stack trace like
this...

Traceback (most recent call last):
  File "/home/dsl11/dev/git-remote-hg/git-remote-hg", line 1254, in <module>
    sys.exit(main(sys.argv))
  File "/home/dsl11/dev/git-remote-hg/git-remote-hg", line 1238, in main
    do_export(parser)
  File "/home/dsl11/dev/git-remote-hg/git-remote-hg", line 1119, in do_export
    if not push(parser.repo, peer, parsed_refs, p_revs):
  File "/home/dsl11/dev/git-remote-hg/git-remote-hg", line 1007, in push
    ret = push_unsafe(repo, remote, parsed_refs, p_revs)
  File "/home/dsl11/dev/git-remote-hg/git-remote-hg", line 990, in push_unsafe
    return remote.unbundle(cg, remoteheads, 'push')
  File "/usr/lib/python2.7/site-packages/mercurial/wireproto.py", line
308, in unbundle
    ret, output = self._callpush("unbundle", cg, heads=heads)
  File "/usr/lib/python2.7/site-packages/mercurial/httppeer.py", line
201, in _callpush
    r = self._call(cmd, data=fp, headers=headers, **args)
  File "/usr/lib/python2.7/site-packages/mercurial/httppeer.py", line
171, in _call
    fp = self._callstream(cmd, **args)
  File "/usr/lib/python2.7/site-packages/mercurial/httppeer.py", line
118, in _callstream
    resp = self.urlopener.open(req)
  File "/usr/lib/python2.7/urllib2.py", line 410, in open
    response = meth(req, response)
  File "/usr/lib/python2.7/urllib2.py", line 523, in http_response
    'http', request, response, code, msg, hdrs)
  File "/usr/lib/python2.7/urllib2.py", line 442, in error
    result = self._call_chain(*args)
  File "/usr/lib/python2.7/urllib2.py", line 382, in _call_chain
    result = func(*args)
  File "/usr/lib/python2.7/urllib2.py", line 897, in http_error_401
    url, req, headers)
  File "/usr/lib/python2.7/site-packages/mercurial/url.py", line 436,
in http_error_auth_reqed
    self, auth_header, host, req, headers)
  File "/usr/lib/python2.7/urllib2.py", line 872, in http_error_auth_reqed
    response = self.retry_http_basic_auth(host, req, realm)
  File "/usr/lib/python2.7/urllib2.py", line 878, in retry_http_basic_auth
    user, pw = self.passwd.find_user_password(realm, host)
  File "/usr/lib/python2.7/site-packages/mercurial/url.py", line 36,
in find_user_password
    raise util.Abort(_('http authorization required'))
mercurial.error.Abort: http authorization required


However, if you don't have a repository to hand you could also do the
following to observe the settings in the repository's hgrc being
respected

1. Clone a repository
$ git clone hg::https://hg.codeplex.com/boogie

2. Add setting to ``.git/hg/origin/clone/.hg/hgrc``

[ui]
quiet = True

3. With the current of git-remote-hg, when you do a pull you see

$ git pull
searching for changes
no changes found
Already up-to-date.

You can see that "quiet" is **not** being respected. If use my patch
to git-remote-hg and run again you see


$ git pull
Already up-to-date.

which shows "quiet" being respected.

>> Prior to this patch the mercurial repository's hgrc file was ignored
>> which I consider to be a bug.
>
> It might be, although the internal repository is not supposed to be used by the
> user.
>
>> Signed-off-by: Dan Liew <delcypher@gmail.com>
>> ---
>>  contrib/remote-helpers/git-remote-hg | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/contrib/remote-helpers/git-remote-hg
>> b/contrib/remote-helpers/git-remote-hg
>> index eb89ef6..451842a 100755
>> --- a/contrib/remote-helpers/git-remote-hg
>> +++ b/contrib/remote-helpers/git-remote-hg
>> @@ -421,7 +421,7 @@ def get_repo(url, alias):
>>
>>          repo = hg.repository(myui, local_path)
>>          try:
>> -            peer = hg.peer(myui, {}, url)
>> +            peer = hg.peer(repo._unfilteredrepo.ui, {}, url)
>
> Why not repo.unfiltered.ui? Or just repo.ui.

using repo.unfiltered.ui makes git-remote-hg return "ERROR: Repository error"

Using "repo.ui" works correctly. I simply did not know that was there
because I was debugging using PyDev in Eclipse and I could only find a
ui object in repo.unfiltered.ui. PyDev does not show "repo.ui" but it
clearly works so using repo.ui is probably better than
repo._unfilteredrepo.ui

Thanks,
Dan Liew.
