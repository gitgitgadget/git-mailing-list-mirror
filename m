From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7] git-p4: improve path encoding verbose output
Date: Tue, 15 Sep 2015 17:59:16 +0200
Message-ID: <46B8F08C-F4A4-43D0-9798-D663F1C5F4BA@gmail.com>
References: <1442250640-93838-1-git-send-email-larsxschneider@gmail.com> <1442250640-93838-2-git-send-email-larsxschneider@gmail.com> <55F7C93D.1080309@diamand.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Sep 15 17:59:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbsdi-0006ln-DK
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbbIOP7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:59:21 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35702 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbbIOP7U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2015 11:59:20 -0400
Received: by wicge5 with SMTP id ge5so35654768wic.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tOrPZNl/WCXUeopucm6wOfZnhttTCTRE4Ixae2NWV9E=;
        b=NipsLZ2uXnVEbCAFC8d6ueiEZG0mbeUEAlURBhJdS5SHY7bM1I7THt6H2244AZ9B13
         Gft8xylML7jCf1lWpWrSJ/wPz4znSHTV4vfSeux6soYpvC8huEb5cBRluz7ubdUE9ELF
         QCBjNI1wecFFX6wVoTkYrecALAxmmduzfmEm7UyUR2QQB/HvdcfVGexDToqVXUaJ+m+J
         beEhFszrXIYv6WZQBJ9ocgtLrg8Yf1ytr5OpRDOejvA71rbOYiIsXjoG5hufJWV7A4wl
         H42KXSNqG8Yolrv01WKsshaHBfDRV/gjx9a5C6HpLPIHKVo7pqBZ67nLkrPgIu4VavjN
         YBHg==
X-Received: by 10.181.13.166 with SMTP id ez6mr8999274wid.24.1442332758574;
        Tue, 15 Sep 2015 08:59:18 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id jw9sm21786160wjb.28.2015.09.15.08.59.17
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Sep 2015 08:59:18 -0700 (PDT)
In-Reply-To: <55F7C93D.1080309@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277948>


On 15 Sep 2015, at 09:31, Luke Diamand <luke@diamand.org> wrote:

> On 14/09/15 18:10, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> If a path with non-ASCII characters is detected then print always the
> 
> s/print always/print/
I will fix it.

> 
> 
>> encoding and the encoded string in verbose mode.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>>  git-p4.py | 19 +++++++++----------
>>  1 file changed, 9 insertions(+), 10 deletions(-)
>> 
>> diff --git a/git-p4.py b/git-p4.py
>> index d45cf2b..da25d3f 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2220,16 +2220,15 @@ class P4Sync(Command, P4UserMap):
>>              text = regexp.sub(r'$\1$', text)
>>              contents = [ text ]
>> 
>> -        if gitConfig("git-p4.pathEncoding"):
>> -            relPath = relPath.decode(gitConfig("git-p4.pathEncoding")).encode('utf8', 'replace')
>> -        elif self.verbose:
>> -            try:
>> -                relPath.decode('ascii')
>> -            except:
>> -                print (
>> -                    "Path with Non-ASCII characters detected and no path encoding defined. "
>> -                    "Please check the encoding: %s" % relPath
>> -                )
>> +        try:
>> +            relPath.decode('ascii')
>> +        except:
>> +            encoding = 'utf8'
>> +            if gitConfig('git-p4.pathEncoding'):
>> +                encoding = gitConfig('git-p4.pathEncoding')
> 
> It would be better to query this once at startup. Otherwise we're potentially forking "git config" twice per file which on a large repo could become significant. Make it an instance variable perhaps?
solved in other email

> 
>> +                relPath = relPath.decode(encoding).encode('utf8', 'replace')
>> +            if self.verbose:
>> +                print 'Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, relPath)
>> 
>>          self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))

Thanks!