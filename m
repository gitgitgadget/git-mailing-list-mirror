Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C819EC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 13:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B1861078
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 13:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbhJKNyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 09:54:02 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:55695 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237312AbhJKNwm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 09:52:42 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mZvhQ-000BGN-8G; Mon, 11 Oct 2021 14:50:41 +0100
Subject: Re: Some problems for git beginners
To:     ZhangJinbao <zhang709787793@icloud.com>,
        Git List <git@vger.kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>
References: <2EC9E24E-A8FD-4851-9F6A-F3D104465A23@icloud.com>
 <ffe633c5-151a-8646-20ef-be4f50c5f59e@gmail.com>
 <4ef81a4e-e832-1968-3f31-5f15cd0c7320@iee.email>
 <AD10E128-A820-4F84-9173-776DA90686EF@icloud.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <282709c2-3a58-d986-5a57-6174a4849782@iee.email>
Date:   Mon, 11 Oct 2021 14:50:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <AD10E128-A820-4F84-9173-776DA90686EF@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please don't drop the list...

On 11/10/2021 04:00, ZhangJinbao wrote:
>
>
>> 2021年10月9日 下午6:32，Philip Oakley <philipoakley@iee.email
>> <mailto:philipoakley@iee.email>> 写道：
>>
>> On 09/10/2021 10:12, Bagas Sanjaya wrote:
>>> On 09/10/21 14.43, ZhangJinbao wrote:
>>>
>>>> Third, when a commit event occurs, the current blob file stores the
>>>> full amount of data, while the previous version stores the
>>>> incremental data
>>>>
>>>
>>> When you `git commit`, Git will initially write objects related to the
>>> commit (blob, tree, and commit) as loose objects. Some point on the
>>> time, Git will repack many loose objects into one big packfile and
>>> write the corresponding pack index. Delta compression is applied when
>>> writing the packfile.
>>>
>> Git is multi-layered, and multi-faceted. So often the impression given
>> isn't the same as what happens internally.
>>
>> All commits are full snapshots, even if git (normally) shows only the
>> changes for previous diffs.
>>
>> But then git will, at a convenient point 'pack' all those snapshots
>> (fairly efficiently) so that the local git storage of the whole
>> repository, with full history, (typically) is no bigger than the checked
>> out files. The packing is part of that layering.
>>
>> There are similar facet/layer effects from the Staging area ("index") /
>> Object store viewpoints.
>>
>> The
>> https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain
>> <https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain>
>> is worth a read, along with other descriptions.
>>
>> Philip
>>
>
> I'm very glad to hear from you
>
> After further study and practice in recent days, there are still
> several questions to confirm
>
> As the article says: 
> What is also interesting is that the second version of the file is the
> one that is stored intact, whereas the original version is stored as a
> delta — this is because you’re most likely to need faster access to
> the most recent version of the file.
>
> Practice has proved that:
> Using the repo.rb(22KB) file, you can store the original version as a
> delta. But using the test.txt(22B) file, you cannot store the original
> version as a delta. 
> Does this algorithm depend on the size of the file? If so, what is the
> file size boundary?
>
> ——————————————————————————————————————————————————————————
> zhangjinbao@Jinbao test % ls   
> repo.rb
> zhangjinbao@Jinbao test % echo "version 1" > test.txt
> zhangjinbao@Jinbao test % git add .
> zhangjinbao@Jinbao test % git commit -m "Create test.txt"
> [master b4a4c9d] Create test.txt
>  1 file changed, 1 insertion(+)
>  create mode 100644 test.txt
> zhangjinbao@Jinbao test % echo "# version 2" >> test.txt 
> zhangjinbao@Jinbao test % git commit -am "modify test.txt"
> [master c454823] modify test.txt
>  1 file changed, 1 insertion(+)
> zhangjinbao@Jinbao test % git gc
> ...
> zhangjinbao@Jinbao test % git verify-pack -v
> .git/objects/pack/pack-17ceeb7d325a4eb7dab3f6f04dda67daa7515feb.idx 
> c45482367fb06750398339597be1c0679af8ee9a commit 226 157 12
> b4a4c9de03421e9e49eaae3c67cf43c699eb5b98 commit 226 157 169
> bcb782fa38f8b016b263a129d3960f409f285215 commit 231 161 326
> 228b55de49116a358ec7c15ccb291678a014fcc8 commit 175 124 487
> b042a60ef7dff760008df33cee372b945b6e884e blob   22054 5799 611
> d25a248172e09b2ef61bcf45b5ec29435da23241 blob   22 26 6410
> aef683d9d2619240c4fa1dcb5a04ea8cbe1de89a tree   71 79 6436
> fdd7ee840023b632768fdcdc08a3465a0c4d46ed tree   71 78 6515
> 83baae61804e65cc73a7201a7252750c76066a30 blob   10 19 6593
> a1ca41f02e3519c32aafb8f4d4d9f465c8ce587a tree   35 46 6612
> 38feecbdf638935287fd920e8f2d694aa8c28d9f tree   35 46 6658
> 033b4468fa6b2a9547a70d88d1bbe8bf3f9ed0d5 blob   9 20 6704 1
> b042a60ef7dff760008df33cee372b945b6e884e
> 非 delta：11 个对象
> 链长 = 1: 1 对象
> .git/objects/pack/pack-17ceeb7d325a4eb7dab3f6f04dda67daa7515feb.pack: ok
> zhangjinbao@Jinbao test % 
>
> --zhangjinbao

The packing is a heuristic, which is explained in narrative (story) form
here: https://git-scm.com/docs/pack-heuristics
--
Philip
