From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 5/8] contrib: cc-cmd: add option to parse from committish
Date: Fri, 19 Apr 2013 13:29:10 -0500
Message-ID: <CAMP44s0ASLAaRMbGHsahHONzuGMC96rw5m72fM5EWpkYp==5uA@mail.gmail.com>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
	<1366348458-7706-6-git-send-email-felipe.contreras@gmail.com>
	<7vtxn21jvt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 20:29:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTG3h-0006vg-4e
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 20:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab3DSS3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 14:29:13 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:37610 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab3DSS3M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 14:29:12 -0400
Received: by mail-la0-f47.google.com with SMTP id fk20so3566381lab.20
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=AeldMSdbaXSc3UMFqfBiGD9/H4JHc6/F5r8KoNCFXm0=;
        b=WOUbkUXq+vvyovOe7A6G48AwHrsodXxeNUBGEa6R2IR81futglqg2o4xX0UFV9S2cS
         0osopsNOovMcVnU168mVFy/8T9avi1kK41DRXt8fM7QhBWNJNexDCUYvvKPSjGbPBhST
         Siihm7Lr5IXwgTSz2JDQWgGISaj3yw8AGg8jzEcg0JnBBa7CMU2nv2VLvwpizUAnPSlB
         q12XaWM9EVxtmBwta29GKVYHSKfvrIDDpvrfO9yH7XRj0UTITdMDaR4RVPrPcUQRA1cz
         WWKsSk92nfPW0/amnwhtsCYciGFZqKVn/ZzbiJDa8eOBt87K9hbPZrN7AR2RbPr1TaUg
         euGw==
X-Received: by 10.112.135.3 with SMTP id po3mr5457648lbb.103.1366396150843;
 Fri, 19 Apr 2013 11:29:10 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Fri, 19 Apr 2013 11:29:10 -0700 (PDT)
In-Reply-To: <7vtxn21jvt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221793>

On Fri, Apr 19, 2013 at 12:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> For example master..feature-a.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  contrib/cc-cmd/git-cc-cmd | 36 ++++++++++++++++++++++++++++++++++--
>>  1 file changed, 34 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
>> index f13ed8f..462f22c 100755
>> --- a/contrib/cc-cmd/git-cc-cmd
>> +++ b/contrib/cc-cmd/git-cc-cmd
>> @@ -5,11 +5,13 @@ require 'optparse'
>>  $since = '3-years-ago'
>>  $min_percent = 5
>>  $show_commits = false
>> +$files = []
>> +$rev_args = []
>>
>>  begin
>>    OptionParser.new do |opts|
>>      opts.program_name = 'git cc-cmd'
>> -    opts.banner = 'usage: git cc-cmd [options] <files>'
>> +    opts.banner = 'usage: git cc-cmd [options] <files | rev-list options>'
>>
>>      opts.on('-p', '--min-percent N', Integer, 'Minium percentage of role participation') do |v|
>>        $min_percent = v
>> @@ -134,10 +136,40 @@ class Commits
>>      end
>>    end
>>
>> +  def from_rev_args(args)
>> +    return if args.empty?
>> +    source = nil
>> +    File.popen(%w[git rev-list --reverse] + args) do |p|
>> +      p.each do |e|
>> +        id = e.chomp
>> +        @main_commits[id] = true
>> +        File.popen(%w[git --no-pager show -C --oneline] + [id]) do |p|
>
> When you know you are sending its output to a pipe, does --no-pager matter,
> or is there anything more subtle going on here?
>
> An extra --no-pager does not hurt, but it just caught/distracted my
> attention while reading this patch.

It probably doesn't matter, I might have been using something else
when I copied that code.

-- 
Felipe Contreras
